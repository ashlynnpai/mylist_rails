require 'spec_helper'

describe NotesController do
  
  describe 'GET new' do
    it "assigns a new note as @note" do
      get :new
      assigns(:note).should be_new_record
      assigns(:note).kind_of?(Note).should be_truthy
    end
  end
  
  describe 'POST create' do
    context "with authenticated users" do
      let(:cast) { Fabricate(:cast) }
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      context 'with valid input' do
        it 'redirects to cast_path' do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note), railscast_id: railscast.id
          expect(response).to redirect_to cast_path(cast)
        end
        it 'creates a note associated with the railscast' do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note), railscast_id: railscast.id
          expect(Note.first.railscast).to eq(railscast)
        end
        it "sets the flash success message" do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note), railscast_id: railscast.id
          expect(flash[:success]).not_to be_blank
        end
      end
      context 'with invalid input' do
        it 'redirects to cast_path' do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note, content: nil), railscast_id: railscast.id
          expect(response).to redirect_to cast_path(cast)
        end
        it 'does not create a note' do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note, content: nil), railscast_id: railscast.id
          expect(Note.count).to eq(0)
        end
        it "sets the flash danger message" do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note, content: nil), railscast_id: railscast.id
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
  end
end
