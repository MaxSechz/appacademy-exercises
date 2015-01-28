class Tagging < ActiveRecord::Base
  validates :tagged_url_id, presence: true
  validates :topic_id, presence: true
  validates :tag_topic, presence: true

  belongs_to(
    :tag_topic,
    class_name: "TagTopic",
    foreign_key: :topic_id,
    primary_key: :id
  )

  belongs_to(
    :tagged_url,
    class_name: "ShortenedUrl",
    foreign_key: :tagged_url_id,
    primary_key: :id
  )

  def self.create_for_url_and_topic(shortened_url, tag_topic)
    Tagging.create!(
      tagged_url_id: shortened_url.id,
      topic_id: tag_topic.id
    )
  end
end
