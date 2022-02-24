class CombatTracker < ApplicationRecord
  has_many :combatants, dependent: :destroy
  belongs_to :encounter

  
  # attr_reader :round, :turn

  # def initialize(encounter)
  #   @encounter = encounter
  #   @round = 1
  #   @turn = 1
  #   transform_to_combatants if combatants.nil?
  # end

  # private

  # def transform_to_combatants
  #   # add players
  #   @encounter.players.map { |p| Combatant.create(parent: p) }

  #   # monsters
  #   @encounter.fates.each do |fate|
  #     fate.group_size.times do
  #       Combatant.create(parent: Monster.find_by(id: fate.monster_id))
  #     end
  #   end
  # end
end
