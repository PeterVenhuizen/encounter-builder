class Combatant < ApplicationRecord
  belongs_to :combat_tracker
  belongs_to :combatable, polymorphic: true

  validates :initiative,
            :current_hp,
            :max_hp,
            numericality: {
              greater_than_or_equal_to: 0
            }

  before_create :set_monster_hp, if: :monster?

  def name
    combatable.name
  end

  def monster?
    combatable.instance_of?(Monster)
  end

  def turn?
    turn
  end

  def inactive?
    current_hp.zero?
  end

  def toggle_turn
    update_attribute(:turn, !turn)
  end

  private

  def set_monster_hp
    self.max_hp = self.current_hp = combatable.hit_points
  end
end
