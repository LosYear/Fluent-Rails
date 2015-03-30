class Admin::PagesController < Admin::AdminController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages_grid = Datagrids::PagesGrid.new(params[:datagrids_pages_grid]) do |scope|
      scope.page(params[:page])
    end

    respond_to do |format|
      if request.xhr? && !request.wiselinks?
        format.html{render partial: 'grid'}
      else
        format.html # index.html.erb
        format.json {render json: Page}
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.author = current_user.id

    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_pages_url, notice: 'Page was successfully created.' }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page.updater = current_user.id
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to admin_pages_url, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to admin_pages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :slug, :content, :status)
    end
end
