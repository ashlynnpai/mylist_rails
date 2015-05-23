class CastsController < ApplicationController
  before_action :require_user
  
  def index
    @casts = current_user.casts
    @watched_casts = current_user.railscasts.done
    @unwatched_casts = current_user.railscasts.todo
  end


  def update
    @cast = Cast.find(params[:id])
    if @cast.update(params.require(:cast).permit(:title, :episode, :watched, :favorite))
      flash[:success] = "Status updating for Episode #{@cast.episode}, #{@cast.title}"
    else
      flash[:danger] = "There was a problem updating the status for Episode #{@cast.episode}, #{@cast.title}"
    end
    redirect_to root_path
  end
  
  def show
    @cast = Cast.find(params[:id])
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
  
  def require_same_user
    redirect_to root_path unless logged_in? and (current_user == @user)
  end

end