class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tagged_url_id
      t.integer :topic_id
      t.timestamps
    end

    add_index(:taggings, :tagged_url_id)
    add_index(:taggings, :topic_id)
  end
end
