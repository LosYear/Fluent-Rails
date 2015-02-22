class Admin::BlocksController < Admin::AdminController
  before_action :set_block, only: [:show, :edit, :update, :destroy]

  # GET /blocks
  # GET /blocks.json
  def index
    @blocks = Block.all

    columns = [
        {:name => 'title', :searchable => true},
        {:name => 'name', :searchable => true, :link => method(:edit_admin_block_path)},
        {:name => 'actions_grid_column', :edit => method(:edit_admin_block_path), :remove => method(:admin_block_path)},
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: GridView::GridView.new(view_context, columns, Block) }
    end
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show
  end

  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @block = Block.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { redirect_to admin_blocks_url, notice: 'Block was successfully created.' }
        format.json { render action: 'show', status: :created, location: @block }
      else
        format.html { render action: 'new' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blocks/1
  # PATCH/PUT /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to admin_blocks_url, notice: 'Block was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to admin_blocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def block_params
      params.require(:block).permit(:title, :content, :name, :type, :status)
    end
end
