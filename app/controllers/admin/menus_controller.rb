class Admin::MenusController < Admin::AdminController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all

    columns = [
        {:name => 'name', :searchable => true,
         :value => Proc.new do |data|
           ActionController::Base.helpers.link_to(data.name, admin_menu_items_path(:menu_id => data.id), :data => {push: true})
         end},
        {:name => 'title', :searchable => true},
        {:name => 'description', :searchable => true},
        {:name => 'actions_grid_column', :edit => method(:edit_admin_menu_path), :remove => method(:admin_menu_path)},
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: GridView::GridView.new(view_context, columns, Menu) }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu_model = Menu.new
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu_model = Menu.new(menu_params)

    respond_to do |format|
      if @menu_model.save
        format.html { redirect_to admin_menus_path, notice: 'Menu was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu_model }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu_model.update(menu_params)
        format.html { redirect_to admin_menus_path, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu_model.destroy
    respond_to do |format|
      format.html { redirect_to admin_menus_path }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu_model = Menu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.require(:menu).permit(:title, :name, :description, :status)
  end
end
