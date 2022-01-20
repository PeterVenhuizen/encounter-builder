class Party
  attr_reader :players

  def initialize(players = [])
    @players = players.uniq
  end

  def size
    @players.count
  end

  def join(player_character)
    @players << player_character unless @players.include?(player_character)
  end

  def leave(player_character)
    @players.delete(player_character)
  end

  def party_xp
    @players.each_with_object({}) do |player, party_xp|
      party_xp.merge!(player.xp_threshold) { |_, v1, v2| v1 + v2 }
    end
  end

  def average_player_level
    @players.count.positive? ? @players.sum { |p| p.level.to_f } / @players.count : 0
  end
end
