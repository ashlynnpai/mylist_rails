class CompletionsController < ApplicationController
  before_action :require_user
  
  def show
    @watched_casts = current_user.railscasts.done
  end
  
end


