class Admin::BlogController < Fluent::Admin::AdminController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_twitter_client, only: [:import_tweets]
  def index
    @posts = Post.where(type: 'post').all

    @posts_grid = Datagrids::PostsGrid.new(params[:datagrids_posts_grid]) do |scope|
      scope.page(params[:page])
    end

    respond_to do |format|
      if request.xhr? && !request.wiselinks?
        format.html{render partial: 'grid'}
      else
        format.html # index.html.erb
        format.json {render json: Posts}
      end
    end
  end

  # GET /blog/1
  # GET /blog/1.json
  def show
  end

  # GET /blog/new
  def new
    @post = Post.new
  end

  # GET /blog/1/edit
  def edit
  end

  # POST /blog
  # POST /blog.json
  def create
    @post = Post.new(post_params)
    @post.type = "post"

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_posts_url, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog/1
  # PATCH/PUT /blog/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_posts_url, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/1
  # DELETE /blog/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end
  
  def maintance

  end

  def import_tweets
    user = Setting.twitter_username

    since_id = nil
    since_id = Post.where(type: 'tweet').maximum(:title) if Post.where(type: 'tweet').count > 0

    tweets = twitter_collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      options[:since_id] = since_id unless since_id.nil?
      options[:exclude_replies] = true
      @twitter_client.user_timeline(user, options)
    end

    tweets.each do |tweet|
      record = Post.new
      record.content = tweet.text
      record.title = tweet.id
      record.created_at = tweet.created_at
      record.slug = 'tweet_' + tweet.id.to_s
      record.type = 'tweet'
      record.save
    end

    respond_to do |format|
      format.html {redirect_to maintance_admin_posts_url, notice: 'Tweets imported successfuly'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :slug, :content, :status, :preview)
    end

    def set_twitter_client
      @twitter_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Setting.twitter_consumer_key
        config.consumer_secret     = Setting.twitter_consumer_secret
        config.access_token        = Setting.twitter_access_token
        config.access_token_secret = Setting.twitter_access_token_secret
      end
    end

    def twitter_collect_with_max_id(collection=[], max_id=nil, &block)
      response = yield(max_id)
      collection += response
      response.empty? ? collection.flatten : twitter_collect_with_max_id(collection, response.last.id - 1, &block)
    end
end
