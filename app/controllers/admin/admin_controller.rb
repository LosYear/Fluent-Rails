class Admin::AdminController < ApplicationController
  layout "admin"
  #wiselinks_layout

  def wiselinks_layout
    'admin_partial'
  end

  before_filter :authenticate_user!, :verify_admin

  def verify_admin
    redirect_to root_url unless current_user.role?('admin')
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end


end