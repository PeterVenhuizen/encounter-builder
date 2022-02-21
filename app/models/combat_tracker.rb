class CombatTracker
  include ActiveModel::Model

  def initialize(encounter)
    @encounter = encounter
  end
end
