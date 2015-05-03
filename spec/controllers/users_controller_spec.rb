require 'spec_helper'

describe UsersController do

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).kind_of?(User).should be_true
    end
    
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
end