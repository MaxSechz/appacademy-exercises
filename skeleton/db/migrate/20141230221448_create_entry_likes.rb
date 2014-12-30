class CreateEntryLikes < ActiveRecord::Migration
  def change
    create_table :entry_likes do |t|
      t.integer :user_id, null: false
      t.integer :entry_id, null: false
      t.timestamps
    end
  end
end
