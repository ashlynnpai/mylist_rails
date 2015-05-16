require 'spec_helper'

describe CastsController do
  
  describe 'GET index' do
    it 'assigns @casts' do
      cast1 = Fabricate(:cast)
      cast2 = Fabricate(:cast)
      get :index
      expect(assigns(:casts)).to eq([cast1, cast2])
    end
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    
    it 'sets @watched_casts' do
      cast1 = Fabricate(:cast, watched: true, updated_at: 3.days.ago)
      cast2 = Fabricate(:cast, watched: false, updated_at: 3.days.ago)
      cast3 = Fabricate(:cast, watched: true, updated_at: 1.day.ago)
      get :index
      expect(assigns(:watched_casts)).to eq([cast3, cast1])
    end
    
    it 'sets @unwatched_casts' do
      cast1 = Fabricate(:cast, watched: false, updated_at: 3.days.ago)
      cast2 = Fabricate(:cast, watched: true, updated_at: 3.days.ago)
      cast3 = Fabricate(:cast, watched: false, updated_at: 1.day.ago)
      get :index
      expect(assigns(:unwatched_casts)).to eq([cast3, cast1])
    end
  end
  
  describe 'PUT update' do
    it 'updates the post' do
      cast = Fabricate(:cast, watched: false)
      put :update, id: cast.id, cast: {watched: true}
      expect(cast.reload.watched).to eq(true)
    end
  end
  
  describe 'GET show' do
    it 'sets @cast' do
      cast = Fabricate(:cast)
      get :show, id: cast.id
      expect(assigns(:cast)).to eq(cast)
    end
  end
  
  describe 'POST makelist' do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      let(:cast) { Fabricate(:cast) }
      before do
        session[:user_id] = user.id
      end
      it 'creates a Railscast record' do
        post :makelist, cast_id: cast.id, user_id: user.id
        expect(Railscast.first.cast_id).to eq(cast.id)
      end
      it 'associates the current user with the cast id' do
        post :makelist, cast_id: cast.id, user_id: user.id
        expect(Railscast.first.cast_id).to eq(cast.id)
      end
      it 'associates the cast with the current user id' do
        post :makelist, cast_id: cast.id, user_id: user.id
        expect(Railscast.first.user_id).to eq(user.id)
      end
    end
  end
  
end