class Admin::MenuItemsController < Admin::AdminController
  before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

  # GET /menu_items
  # GET /menu_items.json
  def index
    @tree = Menu.find(params[:menu_id]).tree
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
    @menu_item.menu_id = params[:menu_id]
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to admin_menu_items_url(:menu_id => @menu_item.menu), notice: 'Menu item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to admin_menu_items_url(:menu_id => @menu_item.menu), notice: 'Menu item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    menu_id = @menu_item.menu
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to admin_menu_items_url(:menu_id => menu_id) }
      format.json { head :no_content }
    end
  end

  # POST /menu_items/change_order
  def change_order
    order = params[:data]

    order.each do |key, value|
      item = MenuItem.find(key)
      item.order = value
      item.save
    end

    render text: t('backend_part.order_saved')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.require(:menu_item).permit(:menu_id, :parent_id, :title, :url, :type, :order, :status)
    end
end
