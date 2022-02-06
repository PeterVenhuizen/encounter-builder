class Party < ApplicationRecord
  has_many :encounters, dependent: :destroy
  has_many :players, dependent: :destroy

  validates :name, length: { minimum: 2 }, uniqueness: true
  validates :players, presence: { message: 'must have at least one player' }

  accepts_nested_attributes_for :players, allow_destroy: true

  default_scope { order(name: :asc) }

  def party_size
    players.count
  end

  def average_player_level
    players.sum(&:level) / players.count.to_f
  end

  def party_xp
    players.each_with_object({}) do |player, party_xp|
      party_xp.merge!(player.xp) { |_, v1, v2| v1 + v2 }
    end
  end
end
