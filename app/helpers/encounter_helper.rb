module EncounterHelper
  def encounter_emoji(difficulty)
    emoji_per_difficulty = {
      none: '&#x1f642;',
      trivial: '&#x1f604;',
      easy: '&#x1f642;',
      medium: '&#x1f610;',
      hard: '&#x1f628;',
      deadly: '&#x1f635;'
    }
    emoji_per_difficulty[difficulty].html_safe
  end

  def avg_level(players)
    players.count.positive? ? players.sum { |p| p[:level].to_f } / players.count : 0
  end

  def difficulty_perc(adjusted_xp, party)
    party_xp = party.party_xp
    xp_threshold = party_xp.key?(:deadly) ? party_xp[:deadly] : 20
    [adjusted_xp.to_f / xp_threshold * 100, 100].min
  end
end
