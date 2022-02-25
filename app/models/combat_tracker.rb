class CombatTracker < ApplicationRecord
  has_many :combatants, -> { order(initiative: :desc) }, dependent: :destroy
  belongs_to :encounter

  after_create :create_combatants

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
end
