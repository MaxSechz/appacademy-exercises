class AddIndexToUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :user_name, false
    add_index :users, :user_name, unique: true
  end
end
