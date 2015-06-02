class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.timestamps
      t.integer :railscast_id
    end
  end
end
