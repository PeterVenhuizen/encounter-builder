class PartyPresenter
  def initialize(party)
    @party = party
  end

  def summary
    "# of characters: #{@party.party_size} | average player level: #{ '%.2f' % @party.average_player_level }"
  end

  def xp
    @party.party_xp.stringify_keys
  end
end
