class EncounterCalculator
  attr_reader :party, :monsters

  def initialize(party = Party.new, monsters = [])
    @party = party
    @monsters = monsters
  end

  def add_monster(monster)
    @monsters << monster
  end

  def summary
    award_xp = @monsters.sum(&:xp)
    adjusted_xp = award_xp * multiplier

    # determine the difficulty
    difficulties = %i[trivial easy medium hard deadly]
    idx = party.party_xp.values.count { |v| adjusted_xp >= v }
    difficulty = @monsters.empty? || @party.players.empty? ? :none : difficulties[idx]

    { award_xp: award_xp, adjusted_xp: adjusted_xp, multiplier: multiplier, difficulty: difficulty }
  end

  private

  def multiplier
    multipliers = [0.5, 1, 1.5, 2, 2.5, 3, 4, 5]

    idx = 1
    case @monsters.size
    when 0..1 then idx = 1
    when 2 then idx = 2
    when 3..6 then idx = 3
    when 7..10 then idx = 4
    when 11..14 then idx = 5
    else idx = 6
    end

    # small party makes it a harder encounter
    idx += 1 if (1..2).include?(@party.size)

    # big party makes an encounter easier
    idx -= 1 if @party.size >= 6

    multipliers[idx]
  end
end