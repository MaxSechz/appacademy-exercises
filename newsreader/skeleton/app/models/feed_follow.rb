class FeedFollow < ActiveRecord::Base
  validates :feed_id, :user_id, presence: true
  belongs_to :feed
  belongs_to :user
end
