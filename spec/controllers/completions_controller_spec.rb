require 'spec_helper'

describe CompletionsController do

  describe 'GET show' do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end   
      it 'assigns @watched_casts' do
        cast1 = Fabricate(:cast)
        cast2 = Fabricate(:cast)
        cast3 = Fabricate(:cast)
        railscast1 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: true)
        railscast2 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: false)
        railscast3 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: true)
        get :show
        expect(assigns(:watched_casts)).to eq([railscast3, railscast1])
      end
    end
    context 'with unauthenticated user' do
      let(:user) { Fabricate(:user) }
      it 'redirects to login' do
        cast1 = Fabricate(:cast)
        railscast1 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: true)
        get :show
        expect(response).to redirect_to(login_path)
      end
    end
  end  
end
