class NotesController < ApplicationController
  before_action :require_user
  
  def create
    @railscast = Railscast.find(params[:railscast_id])
    @note = @railscast.notes.build(params.require(:note).permit(:content))
    @note.creator = current_user
    if @note.save
      flash[:success] = "Your note was created."
      redirect_to railscast_path(@railscast)
    else
      flash[:danger] = "Your note was not created."
      @notes = @railscast.notes.reload
      render 'casts/show'
    end
  end
    
    def edit
      @note = Note.find(params[:id])
      @railscast = @note.railscast
    end
end