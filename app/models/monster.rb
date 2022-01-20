class Monster < ApplicationRecord
  include XP
  default_scope { order(name: :asc) }
  after_initialize :init

  validates :name, presence: { minimum: 2, message: 'must be at least 2 characters long' }
  validates :challenge_rating, inclusion: { in: %w[1/8 1/4 1/2] + [*'0'..'30'] }
  validates :size, inclusion: { in: %w[Tiny Small Medium Large Huge Gargantuan] }
  validates :species, inclusion: { in: %w[Aberration Beast Celestial Construct Dragon Elemental Fey Fiend Giant Humanoid Monstrosity Ooze Plant Undead] }
  validates :armor_class, presence: true
  validates_format_of :hit_points, with: /(\d+)(?: \((\d+d\d+(?: [+-] \d+)?)\))?/i

  def init
    self.challenge_rating ||= '0'
  end

  def xp
    XP_BY_CHALLENGE_RATING[challenge_rating]
  end
end
