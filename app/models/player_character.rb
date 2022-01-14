class PlayerCharacter
  include ActiveModel::Model
  include XP

  attr_reader :name, :level

  def initialize(params)
    @name = params[:name]
    @level = params[:level].to_i
  end

  def xp_threshold(difficulty = nil)
    difficulty.nil? ? XP_BY_CHARACTER_LEVEL[@level] : XP_BY_CHARACTER_LEVEL[@level][difficulty.to_sym]
  end
end
