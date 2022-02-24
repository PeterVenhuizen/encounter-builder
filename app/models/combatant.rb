class Combatant < ApplicationRecord
  belongs_to :combat_tracker
  belongs_to :combatable, polymorphic: true

  attr_accessor :parent

  validates :initiative, numericality: { greater_than_or_equal_to: 0 }

  def name
    parent.name
  end

  def monster?
    parent.instance_of?(Monster)
  end

  def turn?
    turn
  end

  def inactive?
    hit_points.zero?
  end
end
