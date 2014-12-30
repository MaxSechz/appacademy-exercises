class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  after_initialize :ensure_session_token

  has_many :feed_follows
  has_many :followed_feeds, through: :feed_follows, source: :feed

  has_many :entry_likes
  has_many :liked_entries, through: :entry_likes, source: :entry

  attr_reader :password

  def password=(new_pass)
    self.password_digest = BCrypt::Password.create(new_pass)
    self.password = new_pass
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end

  def reset_token!
    self.session_token = self.class.generate_token
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password).is_password?(password)
  end

  def self.find_by_credentials(credentials)
    user = User.find_by(username: credentials[:username])
    return nil if user.nil?
    return user if is_password?(credentials[:password])
    nil
  end
end
