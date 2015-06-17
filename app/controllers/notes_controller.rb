class NotesController < ApplicationController
  before_action :require_user
  
  def create
    @railscast = Railscast.find(params[:railscast_id])
    @note = @railscast.notes.build(params.require(:note).permit(:content))
    if @note.save
      flash[:success] = "Your note was created."
      redirect_to cast_path(@railscast.cast)
    else
      flash[:danger] = "Your note was not created."
      @notes = @railscast.notes.reload
      render 'casts/show'
    end
    
  end

end