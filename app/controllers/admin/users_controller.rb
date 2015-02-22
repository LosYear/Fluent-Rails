class Admin::UsersController < Admin::AdminController
  #load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    columns = [
        {:name => 'id', :searchable => true},
        {:name => 'email', :searchable => true, :link => method(:edit_admin_user_path)},
        {:name => 'created_at', :searchable => true, :format => method(:format_date)},
        {:name => 'actions_grid_column', :edit => method(:edit_admin_user_path), :remove => method(:admin_user_path)},
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: GridView::GridView.new(view_context, columns, User) }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user.attributes = params[:user]
    @user.role_ids = params[:user][:role_ids] if params[:user]
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { redirect_to admin_users_path, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { render :action => "new"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.role_ids = params[:user][:role_ids] if params[:user]
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to admin_users_path, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :ok }
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :username, :role_ids)
  end

  def format_date date
    date.strftime("%B %e, %Y")
  end
end