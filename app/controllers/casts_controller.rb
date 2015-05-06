class CastsController < ApplicationController
  
  def index
    @casts = Cast.all
  end

  def update
    @cast = Cast.find(params[:id])
    if @cast.update(params.require(:cast).permit(:title, :episode, :watched, :favorite))
      redirect_to root_path
    end
  end
  
  private
  

end