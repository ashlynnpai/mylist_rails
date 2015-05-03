require 'spec_helper'

describe SessionsController do
  describe 'GET new' do
    it "redirects to the home page for authenticated users" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new      
    end
  end 
end