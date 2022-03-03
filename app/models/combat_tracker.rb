class CombatTracker < ApplicationRecord
  has_many :combatants, -> { order(initiative: :desc) }, dependent: :destroy
  belongs_to :encounter

  after_create :create_combatants

  accepts_nested_attributes_for :combatants, allow_destroy: true

  def next_turn
    self.turn = (turn % combatants.count) + 1
    next_round if turn == 1
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
  end

  def next_round
    self.round += 1
  end
end
