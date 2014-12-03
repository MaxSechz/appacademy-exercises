class User<ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: :true

  has_many :contact_shares,
    class_name: 'ContactShare',
    foreign_key: :user_id,
    primary_key: :id

  has_many :contacts,
      class_name: 'Contact',
      foreign_key: :user_id,
      primary_key: :id

  has_many :shared_contacts, through: :contact_shares, source: :contact
end
