require 'spec_helper'

describe RailscastsController do
  describe "GET show" do
    context 'with authenticated user' do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end
      it "assigns @railscasts" do
        cast = Fabricate(:cast)
        railscast = Railscast.create(user_id: user.id, cast_id: cast.id)
        get :show, id: railscast.id
        expect(assigns(:railscast)).to eq(railscast)
      end
      it 'assigns @note' do
        cast = Fabricate(:cast)
        railscast = Railscast.create(user_id: user.id, cast_id: cast.id)
        get :show, id: railscast.id
        assigns(:note).should be_new_record
        assigns(:note).kind_of?(Note).should be_truthy
      end
    end
    context 'with unauthenticated user' do
      let(:user) { Fabricate(:user) }
      it 'redirects to login' do
        cast = Fabricate(:cast)
        railscast = Railscast.create(user_id: user.id, cast_id: cast.id)
        get :show, id: railscast.id
        expect(response).to redirect_to login_path
      end
    end    
  end
end