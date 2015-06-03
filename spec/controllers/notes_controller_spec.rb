require 'spec_helper'

describe NotesController do
  
  describe 'GET new' do
    it "assigns a new note as @note" do
      get :new
      assigns(:note).should be_new_record
      assigns(:note).kind_of?(Note).should be_truthy
    end
  end
end
