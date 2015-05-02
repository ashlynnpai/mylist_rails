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
  end
  
end