class Monster
  include ActiveModel::Model
  include XP

  attr_reader :name, :cr

  # def initialize(params)
  #   @name = params[:name]
  #   @cr = params[:cr].to_i
  #   @xp = params[:xp]
  # end

  def initialize(args = {})
    defaults = {
      name: '',
      cr: '0'
    }
    args.reverse_merge(defaults).each do |attr, val|
      instance_variable_set("@#{attr}", val) unless val.nil?
    end

    raise ArgumentError, 'CR must be between 0 and 30' unless XP_BY_CHALLENGE_RATING.key?(@cr)
  end

  def xp
    @xp.nil? ? XP_BY_CHALLENGE_RATING[@cr] : @xp
  end
end
