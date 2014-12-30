class EntryLike < ActiveRecord::Base
  validates :user_id, :entry_id, presence: true
  belongs_to :entry
  belongs_to :user
end
