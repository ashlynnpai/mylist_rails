class Cast < ActiveRecord::Base
  
  has_many :railscasts
  has_many :users, through: :railscasts
    
end