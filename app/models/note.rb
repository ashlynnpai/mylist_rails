class Note < ActiveRecord::Base

  belongs_to :railscast, foreign_key: 'railscast_id'
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User' 
  
  validates :content, presence: true
  
end