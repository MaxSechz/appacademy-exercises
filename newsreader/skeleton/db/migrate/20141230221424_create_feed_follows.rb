class CreateFeedFollows < ActiveRecord::Migration
  def change
    create_table :feed_follows do |t|
      t.integer :feed_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
