class CastsController < ApplicationController
  before_action :require_user
  
  def index
    @casts = current_user.casts
    @watched_casts = current_user.railscasts.done
    @unwatched_casts = current_user.railscasts.todo
  end


  def update
    @cast = Cast.find(params[:id])
    if @cast.update(params.require(:cast).permit(:title, :episode))
      flash[:success] = "Status updating for Episode #{@cast.episode}, #{@cast.title}"
    else
      flash[:danger] = "There was a problem updating the status for Episode #{@cast.episode}, #{@cast.title}"
    end
    redirect_to root_path
  end
  
  def show
    @cast = Cast.find(params[:id])
  end

  def toggle_watched
    @railscast = Railscast.find(params[:id])
    @cast = Railscast.find(params[:cast_id])
    watched_status = params[:watched]
      if find_railscast
        find_railscast.update_column(:watched, watched_status)
        find_railscast.save  
      else
        flash[:danger] = "Error."
      end
    redirect_to casts_path
  end
  
  def makelist
    casts = Cast.all
    
    casts.each do |cast|
      railscast = Railscast.new(cast: cast, user: current_user)
      railscast.save
    end
    redirect_to root_path
  end

  private

  def find_railscast
    railscast = Railscast.where(user_id: current_user.id, cast: @cast).first
  end
  
  def require_same_user
    redirect_to root_path unless logged_in? and (current_user == @user)
  end

end