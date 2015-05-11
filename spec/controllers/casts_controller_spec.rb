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
  
end