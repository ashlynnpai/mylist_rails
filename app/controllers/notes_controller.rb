class NotesController < ApplicationController
  before_action :require_user
  
  def new
    @note = Note.new
  end
  
  def create
    @railscast = Railscast.find(params[:railscast_id])
    @note = @railscast.notes.build(params.require(:note).permit(:content))
    if @note.save
      flash[:success] = "Your note was created."
    else
      flash[:danger] = "Your note was not created."
    end
    redirect_to cast_path(@railscast.cast)
  end
  
  def show
    @note = Note.find(params[:id])
  end

end