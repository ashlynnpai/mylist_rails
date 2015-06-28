require 'spec_helper'

describe CompletionsController do

  describe 'GET show' do
    let(:user) { Fabricate(:user) }
    before do
      session[:user_id] = user.id
    end   
    it 'assigns @watched_casts' do
      cast1 = Fabricate(:cast)
      railscast1 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: true)
      get :show
      expect(assigns(:watched_casts)).to eq([railscast1])
    end
  end  
end
