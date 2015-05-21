class DashboardsController < ApplicationController
  before_action :require_user
  
  def show
    @user = current_user
    require_same_user
  end
  
  private
  
  def require_same_user
    redirect_to root_path unless logged_in? and (current_user == @user)
  end
  
end