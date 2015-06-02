require 'spec_helper'

describe Railscast do
  
  it { should belong_to(:user) }
  it { should belong_to(:cast) }
  it { should have_many(:notes) }
  
end