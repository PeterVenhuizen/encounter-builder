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

  def create_combatants
    # create Combatants from players
    encounter.players.each { |p| self.combatants.create(combatable: p) }

    # create Combatants from monsters
    encounter.fates.each do |fate|
      fate.group_size.times do
        self.combatants.create(combatable: fate.monster)
      end
    end
  end

  def next_round
    self.round += 1
  end
end
