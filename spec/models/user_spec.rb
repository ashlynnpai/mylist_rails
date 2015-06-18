
require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:name) }
  
  it { should have_many(:casts) }
  it { should have_many(:notes) }
  
end