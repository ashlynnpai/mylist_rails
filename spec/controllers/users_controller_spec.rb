require 'spec_helper'

describe UsersController do

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).kind_of?(User).should be_truthy
    end
    
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      let(:cast){ Fabricate(:cast) }
      it "creates user record" do
        expect(User.count).to eq(1)
      end
      it "redirects to home" do
        expect(response).to redirect_to root_path
      end
    end
    
    context "with invalid input" do
      before { post :create, user: {password: "pass"} }
      it "does not create the user" do
        expect(User.count).to eq(0)
      end
      it "renders the :new template" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
  
  describe 'GET show' do
    let(:user){ Fabricate(:user) }
    it "sets @user" do
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
    it "renders the :show template" do
      get :show, id: user.id
      expect(response).to render_template(:show)
    end
  end
  
end