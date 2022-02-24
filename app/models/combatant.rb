class Combatant < ApplicationRecord
  belongs_to :combat_tracker
  belongs_to :combatable, polymorphic: true

  validates :initiative, numericality: { greater_than_or_equal_to: 0 }

  def name
    self.combatable.name
  end

  def monster?
    self.combatable.instance_of?(Monster)
  end

  def turn?
    turn
  end

  def inactive?
    hit_points.zero?
  end
end
