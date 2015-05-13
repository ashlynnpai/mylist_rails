class Cast < ActiveRecord::Base
  
  scope :done, ->{ where(watched: true).order("updated_at desc") }
  scope :todo, ->{ where(watched: false).order("updated_at desc") }
  
  has_many :railscasts
  has_many :users, through: :railscasts

end