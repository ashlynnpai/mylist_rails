class Note < ActiveRecord::Base

  belongs_to :railscast, foreign_key: 'railscast_id'
  
end