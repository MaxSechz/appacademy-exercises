class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :topic_id,
    primary_key: :id
  )

  has_many(
    :tagged_urls,
    through: :taggings,
    source: :tagged_url
  )

  def most_popular(n)
    tagged_urls.joins(:visits).group(:short_url).order('count(visits.id) DESC').limit(n)
  end
end
