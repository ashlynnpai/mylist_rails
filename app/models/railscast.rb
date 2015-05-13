class Railscast < ActiveRecord::Base
  belongs_to :user
  belongs_to :cast
end