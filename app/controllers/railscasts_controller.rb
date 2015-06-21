class RailscastsController < ApplicationController
  before_action :require_user
  
  def show
    @railscast = Railscast.find(params[:id])
    @notes = @railscast.notes
    @note = Note.new
  end

  
end