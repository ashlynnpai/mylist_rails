class AddCommentToRailscast < ActiveRecord::Migration
  def change
    add_column :railscasts, :comment, :text
  end
end
