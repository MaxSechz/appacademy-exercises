class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates_uniqueness_of(:user_id, scope: :email)

  belongs_to :owner,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_many :contact_shares,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    primary_key: :id,
    dependent: :destroy

  has_many :shared_users, through: :contact_shares, source: :user
end
