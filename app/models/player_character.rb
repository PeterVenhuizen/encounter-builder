class PlayerCharacter
  include ActiveModel::Model
  include XP

  attr_reader :name, :level, :id

  def initialize(args = {})
    defaults = {
      name: '',
      level: '1'
    }
    args.reverse_merge(defaults).each do |attr, val|
      instance_variable_set("@#{attr}", val) unless val.nil?
    end

    raise ArgumentError, 'Level must be between 1 and 20' unless XP_BY_CHARACTER_LEVEL.key?(@level)
  end

  def xp_threshold(difficulty = nil)
    difficulty.nil? ? XP_BY_CHARACTER_LEVEL[@level] : XP_BY_CHARACTER_LEVEL[@level][difficulty.to_sym]
  end
end
