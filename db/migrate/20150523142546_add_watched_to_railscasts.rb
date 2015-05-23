class AddWatchedToRailscasts < ActiveRecord::Migration
  def change
    add_column :railscasts, :watched, :boolean
    add_column :railscasts, :watched_on, :datetime
    add_column :railscasts, :favorite, :boolean
  end
end
