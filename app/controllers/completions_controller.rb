class CompletionsController < ApplicationController
  
  def show
    @watched_casts = current_user.railscasts.done
  end
  
end


