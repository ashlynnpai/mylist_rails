class CastsController < ApplicationController
  
  def index
    @casts = Cast.all
    @watched_casts = Cast.done
    @unwatched_casts = Cast.todo
  end

  def update
  @cast = Cast.find(params[:id])

    if @cast.update(params.require(:cast).permit(:title, :episode, :watched, :favorite))
      flash[:success] = "Status changed for Episode #{@cast.episode}, #{@cast.title}"
      redirect_to root_path
    else
      flash[:danger] = "There was a problem changing the status for Episode #{@cast.episode}, #{@cast.title}"
    end
  end

  private
  

end