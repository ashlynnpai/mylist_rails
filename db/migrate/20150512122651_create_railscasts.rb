class CreateRailscasts < ActiveRecord::Migration
  def change
    create_table :railscasts do |t|
      t.integer :user_id, :cast_id
      t.timestamps
    end
  end
end
