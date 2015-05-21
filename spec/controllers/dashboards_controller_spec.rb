require 'spec_helper'

describe DashboardsController do
    
  context 'with authenticated user' do
    let(:user) { Fabricate(:user) }
    before do
      session[:user_id] = user.id
    end
    describe 'GET show' do
      it 'assigns @user' do
        get :show
        expect(assigns(:user)).to eq(user)
      end
      it 'renders the show template' do
        get :show
        expect(response).to render_template('show')
      end
    end
  end
  context 'with unauthenticated user' do
    describe 'GET show' do
      it 'redirects to login' do
        get :show
        expect(response).to redirect_to login_path
      end
    end
  end
end
