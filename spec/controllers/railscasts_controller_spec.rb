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
    end
  end
end