class CastsController < ApplicationController
  
  def index
    @casts = Cast.all
    @watched_casts = Cast.done
    @unwatched_casts = Cast.todo
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
  

end