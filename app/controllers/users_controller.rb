class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    if @user.public_profile == true || @user == current_user
      @watched_casts = @user.railscasts.done
    else
      redirect_to root_path
    end
  end
  
  def edit
    @user = User.find(params[:id])
    require_same_user
  end
  
  def make_private
    @user = current_user
    if current_user
    # validations won't block user update
      if @user.update_attribute(:public_profile, false)
        flash[:success] = "Profile set to private."
      else
        flash[:danger] = "Profile has not been changed."
      end
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end
  
  def make_public
    @user = current_user
    if current_user
      if @user.update_attribute(:public_profile, true)
        flash[:success] = "Profile set to public."
      else
        flash[:danger] = "Profile has not been changed."
      end
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end
  
  def dashboard
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :public_profile)
  end
  
  def require_same_user
    redirect_to root_path unless logged_in? and (current_user == @user)
  end
  
end