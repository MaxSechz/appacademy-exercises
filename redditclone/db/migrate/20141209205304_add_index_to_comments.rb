class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, :parent_comment_id
  end
end
