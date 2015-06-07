require 'spec_helper'

describe Note do
  
  it { should belong_to(:railscast) }
  it { should validate_presence_of(:content) }
  
end