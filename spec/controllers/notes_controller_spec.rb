require 'spec_helper'

describe NotesController do
  
  describe 'POST create' do
    context "with authenticated users" do
      let(:cast) { Fabricate(:cast) }
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }
      context 'with valid input' do
        it 'redirects to cast_path' do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note), railscast_id: railscast.id          
          expect(response).to redirect_to railscast_path(railscast)
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
        it 'renders the template show' do
          railscast = Railscast.create(cast_id: cast.id, user_id: current_user.id)
          post :create, note: Fabricate.attributes_for(:note, content: nil), railscast_id: railscast.id
          expect(response).to render_template('casts/show')
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
    context "with unauthenticated users" do
      let(:cast) { Fabricate(:cast) }
      let(:user) { Fabricate(:user) }
      it 'redirects to login_path' do
        railscast = Railscast.create(cast_id: cast.id, user_id: user.id)
        post :create, note: Fabricate.attributes_for(:note), railscast_id: railscast.id
        expect(response).to redirect_to login_path
      end
    end
  end
  describe "GET edit" do
    let(:note) { Fabricate(:note) }
    it 'renders the template show' do
      get :edit, note: note.id
      expect(response).to render_template :edit
    end
  end
end

