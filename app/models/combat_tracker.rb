class CombatTracker
  include ActiveModel::Model

  attr_reader :round, :turn, :combatants

  def initialize(encounter)
    @encounter = encounter
    @round = 1
    @turn = 1
    transform_to_combatants
  end

  private

  def transform_to_combatants
    # add players
    @combatants = @encounter.players.map { |p| Combatant.new(parent: p) }

    # monsters
    @encounter.fates.each do |fate|
      fate.group_size.times do
        @combatants << Combatant.new(parent: Monster.find_by(id: fate.monster_id))
      end
    end
  end
end
