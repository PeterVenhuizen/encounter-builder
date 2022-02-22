class CombatTracker
  include ActiveModel::Model

  attr_reader :round, :turn, :combatants

  def initialize(encounter)
    @encounter = encounter
    @round = 1
    @turn = 1
  end

  private

  def init_combatants
    
  end
end
