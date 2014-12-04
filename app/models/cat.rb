class Cat < ActiveRecord::Base
  COLORS = %w(black white orange brown)
  validates :birthdate, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS}
  validates :sex, inclusion: { in: %w( M F )}

  def age
    age = Date.today.year - birthdate.year
    age < 1 ? 1 : age
  end
end
