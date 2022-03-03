class Monster < ApplicationRecord
  has_many :fates
  has_many :encounters, through: :fates
  has_many :combatants, as: :combatable

  default_scope { order(name: :asc) }

  validates :name,
            presence: {
              minimum: 2,
              message: 'must be at least 2 characters long'
            }

  validates :challenge_rating,
            inclusion: { in: %w[1/8 1/4 1/2] + [*'0'..'30'] }

  validates :size,
            inclusion: { in: %w[Tiny Small Medium Large Huge Gargantuan] }

  validates :species,
            inclusion: {
              in: %w[Aberration Beast Celestial Construct Dragon Elemental Fey Fiend Giant Humanoid Monstrosity Ooze Plant Undead]
            }

  validates :alignment,
            :armor_class,
            presence: true

  validates :xp,
            numericality: { only_integer: true }

  validates :hit_points,
            numericality: {
              only_integer: true,
              greater_than: 0
            }

  validates :hit_dice,
            format: { with: /(\d+d\d+(?: [+-] \d+)?)/i }

  after_initialize :order_hstores

  def proficiency_bonus
    cr = Rational(challenge_rating).to_i
    cr < 5 ? 2 : 2 + (cr - 1) / 4
  end

  private

  # Enforce expected order for D&D ability scores
  def order_hstores
    order = %w[strength dexterity constitution intelligence wisdom charisma]
    ability_scores.slice!(*order)

    order = %w[walk burrow climb fly swim]
    speed.slice!(*order)
  end
end
