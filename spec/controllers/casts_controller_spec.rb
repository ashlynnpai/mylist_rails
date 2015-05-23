require 'spec_helper'

describe CastsController do
  
  describe 'GET index' do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) } 
      before do
        session[:user_id] = user.id
      end
      it 'assigns @casts' do
        cast1 = Fabricate(:cast)
        cast2 = Fabricate(:cast)
        Railscast.create(user_id: user.id, cast_id: cast1.id)
        Railscast.create(user_id: user.id, cast_id: cast2.id)
        get :index
        expect(assigns(:casts)).to eq([cast1, cast2])
      end
      it 'renders the index template' do
        cast1 = Fabricate(:cast)
        cast2 = Fabricate(:cast)
        get :index
        expect(response).to render_template('index')
      end
      it 'sets @watched_casts' do
        cast1 = Fabricate(:cast, updated_at: 3.days.ago)
        cast2 = Fabricate(:cast, updated_at: 3.days.ago)
        cast3 = Fabricate(:cast, updated_at: 1.day.ago)
        railscast1 = Railscast.create(user_id: user.id, cast_id: cast1.id, watched: true)
        railscast2 = Railscast.create(user_id: user.id, cast_id: cast2.id, watched: false)
        railscast3 = Railscast.create(user_id: user.id, cast_id: cast3.id, watched: true)
        get :index
        expect(assigns(:watched_casts)).to eq([railscast3, railscast1])
      end
      it 'sets @unwatched_casts' do
        cast1 = Fabricate(:cast, updated_at: 3.days.ago)
        cast2 = Fabricate(:cast, updated_at: 3.days.ago)
        cast3 = Fabricate(:cast, updated_at: 1.day.ago)
        railscast1 = Railscast.create(user_id: user.id, cast_id: cast1.id, watched: false)
        railscast2 = Railscast.create(user_id: user.id, cast_id: cast2.id, watched: true)
        railscast3 = Railscast.create(user_id: user.id, cast_id: cast3.id, watched: false)
        get :index
        expect(assigns(:unwatched_casts)).to eq([railscast3, railscast1])
      end
    end
  end
  
  describe 'PUT update' do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end
      it 'updates the cast' do
        cast = Fabricate(:cast, watched: false)
        put :update, id: cast.id, cast: {watched: true}
        expect(cast.reload.watched).to eq(true)
      end
    end
  end
  
  describe 'GET show' do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end
      it 'sets @cast' do
        cast = Fabricate(:cast)
        get :show, id: cast.id
        expect(assigns(:cast)).to eq(cast)
      end
    end
  end
  
  describe 'PUT toggle_watched' do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      let(:cast) { Fabricate(:cast) }
      before do
        session[:user_id] = user.id
      end
      it 'updates the watched status' do
        railscast = Railscast.create(user_id: user.id, cast_id: cast.id, watched: false)
        put :toggle_watched, id: railscast.id, user_id: user.id, cast_id: cast.id, watched: true
        expect(railscast.reload.watched).to eq(true)
      end
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