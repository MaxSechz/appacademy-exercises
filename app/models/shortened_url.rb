class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )
  
  def self.random_code
    loop do
      short = SecureRandom::urlsafe_base64
      break short if !ShortenedUrl.exists?(short)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: self.random_code
      )
  end
end
