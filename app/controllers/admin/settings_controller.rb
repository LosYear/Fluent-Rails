class Admin::SettingsController < Admin::AdminController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /blocks
  # GET /blocks.json
  def index
    @setting = Setting.unscoped

    columns = [
        {:name => 'var', :searchable => true, :link => method(:edit_admin_setting_path)},
        {:name => 'value', :searchable => true},
        {:name => 'actions_grid_column', :edit => method(:edit_admin_setting_path), :remove => method(:admin_settings_path)},
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: GridView::GridView.new(view_context, columns, Settings) }
    end
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show
  end

  # GET /blocks/new
  def new
    @setting = Setting.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to admin_settings_url, notice: 'Option was successfully created.' }
        format.json { render action: 'show', status: :created, location: @setting }
      else
        format.html { render action: 'new' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blocks/1
  # PATCH/PUT /blocks/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to admin_settings_url, notice: 'Option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to admin_settings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.unscoped.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:var, :value)
    end
end
