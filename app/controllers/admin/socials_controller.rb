class Admin::SocialsController < Fluent::Admin::AdminController
  before_action :set_social, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @socials_grid = Datagrids::SocialsGrid.new(params[:datagrids_socials_grid]) do |scope|
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

  def show
    respond_with(@social)
  end

  def new
    @social = Social.new
    respond_with(@social)
  end

  def edit
  end

  def create
    @social = Social.new(social_params)

    respond_to do |format|
      if @social.save
        format.html { redirect_to admin_socials_url, notice: 'Social was successfully created.' }
        format.json { render action: 'show', status: :created, location: @social }
      else
        format.html { render action: 'new' }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @social.update(social_params)
        format.html { redirect_to admin_socials_url, notice: 'Block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @social.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @social.destroy
    respond_to do |format|
      format.html { redirect_to admin_socials_url }
      format.json { head :no_content }
    end
  end

  private
    def set_social
      @social = Social.find(params[:id])
    end

    def social_params
      params.require(:social).permit(:title, :link, :order, :status, :logo)
    end
end
