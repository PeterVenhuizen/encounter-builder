class Encounter < ApplicationRecord
  has_many :fates, dependent: :destroy
  has_many :monsters, through: :fates
  belongs_to :party

  validates_presence_of :name, :description
  validates :fates, presence: { message: 'requires at least one monster for the encounter' }

  accepts_nested_attributes_for :fates, allow_destroy: true

  default_scope { order(name: :asc) }

  def summary
    {
      total_experience: total_experience,
      number_of_players: party.party_size,
      average_player_level: party.average_player_level,
      difficulty: difficulty
    }
  end

  private

  def total_experience
    monsters.sum { |m| m.xp * Fate.find_by(encounter_id: id, monster_id: m.id).group_size }
  end

  def multiplier
    multipliers = [0.5, 1, 1.5, 2, 2.5, 3, 4, 5]

    number_of_monsters = monsters.sum { |m| Fate.find_by(encounter_id: id, monster_id: m.id).group_size }
    case number_of_monsters
    when 0..1 then idx = 1
    when 2 then idx = 2
    when 3..6 then idx = 3
    when 7..10 then idx = 4
    when 11..14 then idx = 5
    else idx = 6
    end

    # small party makes it a harder encounter
    idx += 1 if (1..2).include?(party.party_size)

    # big party makes an encounter easier
    idx -= 1 if party.party_size >= 6

    multipliers[idx]
  end

  def adjusted_experience
    total_experience * multiplier
  end

  def difficulty
    difficulties = %i[trivial easy medium hard deadly]
    idx = party.party_xp.values.count { |v| adjusted_experience >= v }
    difficulties[idx]
  end
end
