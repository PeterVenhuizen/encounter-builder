class CombatTracker < ApplicationRecord
  has_many :combatants, -> { order(initiative: :desc) }, dependent: :destroy
  belongs_to :encounter

  after_create :create_combatants

  accepts_nested_attributes_for :combatants,
                                allow_destroy: true

  # Track turns, rounds and activate combatants
  def next_turn
    self.turn = (turn % combatants.count) + 1
    next_round if turn == 1
    activate_combatant
  end

  # Returns the active combatants
  def active_combatant
    combatants.find(&:turn?)
  end

  private

  # Create combatants from Players and Monsters
  def create_combatants
    encounter.players.each { |p| combatants.create(combatable: p) }

    encounter.fates.each do |fate|
      fate.group_size.times do
        combatants.create(combatable: fate.monster)
      end
    end

    combatants.first.toggle_turn
  end

  def next_round
    self.round += 1
  end

  # Assign the current active combatant
  def activate_combatant
    combatants.find(&:turn?).toggle_turn
    combatants[turn - 1].toggle_turn
  end
end
