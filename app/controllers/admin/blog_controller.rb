class Admin::BlogController < Admin::AdminController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all

    columns = [
        {:name => 'title', :searchable => true, :link => method(:edit_admin_post_path)},
        {:name => 'slug', :searchable => true},
        {:name => 'actions_grid_column', :edit => method(:edit_admin_post_path), :remove => method(:admin_posts_path)},
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: GridView::GridView.new(view_context, columns, Post) }
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @post = Post.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
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

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
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

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
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
end
