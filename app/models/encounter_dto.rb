class EncounterDTO
  attr_reader :award_xp, :adjusted_xp, :multiplier, :difficulty

  def initialize(award_xp, adjusted_xp, multiplier, difficulty)
    @award_xp = award_xp
    @adjusted_xp = adjusted_xp
    @multiplier = multiplier
    @difficulty = difficulty
  end
end
