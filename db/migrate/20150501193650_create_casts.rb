class CreateCasts < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.integer :episode
      t.string :title
      t.boolean :watched
      t.datetime :watched_on
      t.boolean :favorite
      t.timestamps
    end
  end
end
