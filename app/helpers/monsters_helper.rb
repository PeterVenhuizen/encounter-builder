module MonstersHelper
  def ability_modifier(score)
    (score - 10) / 2
  end
end
