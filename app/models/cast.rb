class Cast < ActiveRecord::Base
  
  scope :done, ->{ where(watched: true) }
  scope :todo, ->{ where(watched: false) }

end