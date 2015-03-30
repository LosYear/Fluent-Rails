class Admin::NewsController < Admin::AdminController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  # GET /news.json
  def index
    @news_grid = Datagrids::NewsGrid.new(params[:datagrids_news_grid]) do |scope|
      scope.page(params[:page])
    end

    respond_to do |format|
      if request.xhr? && !request.wiselinks?
        format.html{render partial: 'grid'}
      else
        format.html # index.html.erb
        format.json {render json: News}
      end
    end
  end

  # GET /news/1
  # GET /news/1.json
  def show
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  # POST /news.json
  def create
    @news = News.new(news_params)
    @news.author = current_user.id

    respond_to do |format|
      if @news.save
        format.html { redirect_to admin_news_index_url, notice: 'news was successfully created.' }
        format.json { render action: 'show', status: :created, location: @news }
      else
        format.html { render action: 'new' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news/1
  # PATCH/PUT /news/1.json
  def update
    @news.updater = current_user
    respond_to do |format|
      if @news.update(news_params)
        format.html { redirect_to admin_news_index_url, notice: 'news was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news/1
  # DELETE /news/1.json
  def destroy
    @news.destroy
    respond_to do |format|
      format.html { redirect_to admin_news_index_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :slug, :content, :status)
    end
end
