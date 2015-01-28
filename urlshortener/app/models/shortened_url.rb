class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true, length:  {maximum: 1024}
  validates :short_url, presence: true, uniqueness: true
  validate :has_not_submitted_too_frequently

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :tagged_url_id,
    primary_key: :id
  )

  has_many(
    :topics,
    through: :taggings,
    source: :tag_topic
  )
  def self.random_code
    loop do
      short = SecureRandom::urlsafe_base64
      break short if !ShortenedUrl.exists?(short)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url, tag = nil)
    new_url = ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: self.random_code
    )

    Tagging.create_for_url_and_topic(new_url, tag) unless tag.nil?

    new_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select(:user_id).distinct.where(created_at: (10.minutes.ago)..Time.now).count
  end

  def has_not_submitted_too_frequently
    number = ShortenedUrl.where(created_at: (1.minute.ago)..Time.now, submitter_id: submitter_id).count
    if number >= 5
      errors[:base] << "You tried to submit too many urls too frequently"
    end
  end
end
