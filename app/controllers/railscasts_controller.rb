class RailscastsController < ApplicationController
  before_action :require_user
  
  def show
    @railscast = Railscast.find(params[:id])
  end

  
end