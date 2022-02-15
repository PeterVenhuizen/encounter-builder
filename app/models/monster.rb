class Monster < ApplicationRecord
  has_many :fates
  has_many :encounters, through: :fates

  default_scope { order(name: :asc) }

  validates :name, presence: { minimum: 2, message: 'must be at least 2 characters long' }
  validates :challenge_rating, inclusion: { in: %w[1/8 1/4 1/2] + [*'0'..'30'] }
  validates :size, inclusion: { in: %w[Tiny Small Medium Large Huge Gargantuan] }
  validates :species, inclusion: { in: %w[Aberration Beast Celestial Construct Dragon Elemental Fey Fiend Giant Humanoid Monstrosity Ooze Plant Undead] }
  validates :alignment, presence: true
  validates :armor_class, presence: true
  validates :hit_points, numericality: { only_integer: true, greater_than: 0 }
  validates_format_of :hit_dice, with: /(\d+d\d+(?: [+-] \d+)?)/i

  XP_BY_CHALLENGE_RATING = {
    '0' => 10,
    '1/8' => 25,
    '1/4' => 50,
    '1/2' => 100,
    '1' => 200,
    '2' => 450,
    '3' => 700,
    '4' => 1100,
    '5' => 1800,
    '6' => 2300,
    '7' => 2900,
    '8' => 3900,
    '9' => 5000,
    '10' => 5900,
    '11' => 7200,
    '12' => 8400,
    '13' => 10_000,
    '14' => 11_500,
    '15' => 13_000,
    '16' => 15_000,
    '17' => 18_000,
    '18' => 20_000,
    '19' => 22_000,
    '20' => 25_000,
    '21' => 33_000,
    '22' => 41_000,
    '23' => 50_000,
    '24' => 62_000,
    '25' => 75_000,
    '26' => 90_000,
    '27' => 105_000,
    '28' => 120_000,
    '29' => 135_000,
    '30' => 155_000
  }.freeze

  def xp
    XP_BY_CHALLENGE_RATING[challenge_rating]
  end
end  