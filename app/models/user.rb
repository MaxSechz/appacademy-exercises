class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true
  after_initialize :reset_session_token!

  attr_reader :password

  def reset_session_token!
    session_token = SecureRandom::urlsafe_base64(16)
    session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    user.first.password.is_password?(password) ? user : nil
  end
end
