class Monster
  include ActiveModel::Model
  include XP

  attr_reader :name, :cr

  def initialize(params)
    @name = params[:name]
    @cr = params[:cr].to_i
    @xp = params[:xp]
  end

  def bullshit
    'bullshit'
  end

  def xp
    @xp.nil? ? XP_BY_CHALLENGE_RATING[@cr] : @xp
  end
end
