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
    context "with authenticated user" do
      let(:user){ Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end
      it "sets @user" do
        get :show, id: user.id
        expect(assigns(:user)).to eq(user)
      end
      it "renders the :show template" do
        get :show, id: user.id
        expect(response).to render_template(:show)
      end
      it "sets @watched_casts" do
        cast1 = Fabricate(:cast)
        cast2 = Fabricate(:cast)
        cast3 = Fabricate(:cast)
        railscast1 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: true)
        railscast2 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: false)
        railscast3 = Railscast.create(cast_id: cast1.id, user_id: user.id, watched: true)
        get :show, id: user.id
        expect(assigns(:watched_casts)).to eq([railscast3, railscast1])
      end
    end
    context "with unauthenticated user" do
      context "with profile set to public" do  
        let(:user){ Fabricate(:user, public_profile: true) }
        it "shows the public profile" do
          get :show, id: user.id
          expect(response).to render_template(:show)
        end
      end
      context "with profile set to private" do  
        let(:user){ Fabricate(:user, public_profile: false) }
        it "redirects to the root path" do
          get :show, id: user.id
          expect(response).to redirect_to root_path
        end
      end
    end
  end
  
  describe "GET edit" do
    context "with authenticated user" do
      let(:user){ Fabricate(:user) }
      before {session[:user_id] = user.id}
      it "renders the edit template" do
        get :edit, id: user.id
        expect(response).to render_template :edit
      end
      it "sets @user" do
        get :edit, id: user.id
        expect(assigns(:user)).to eq(user)
      end
    end
    context "with unauthenticated user" do
      let(:user){ Fabricate(:user) }
      it "redirects to the root path" do
        get :edit, id: user.id
        expect(response).to redirect_to root_path
      end
    end
    describe "make private" do
      let(:user){ Fabricate(:user) }
      it "redirects to the user path" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(response).to redirect_to dashboard_path
      end
      it "sets the flash success message" do
        patch :make_private, id: user.id, user: {public_profile: false}
        expect(flash[:success]).to be_present
      end
    end
  end 
end