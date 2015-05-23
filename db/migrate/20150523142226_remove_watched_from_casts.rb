class RemoveWatchedFromCasts < ActiveRecord::Migration
  def change
    remove_column :casts, :watched, :boolean
    remove_column :casts, :watched_on, :datetime
    remove_column :casts, :favorite, :boolean
  end
end


  