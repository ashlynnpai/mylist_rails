class Railscast < ActiveRecord::Base
  belongs_to :user
  belongs_to :cast
  
  scope :done, ->{ where(watched: true).order("updated_at desc") }
  scope :todo, ->{ where(watched: false).order("updated_at desc") }
end