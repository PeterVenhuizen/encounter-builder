module MonstersHelper
  # def parse_monster(response)
  def parse_monster
    response = {:index=>"bandit", :name=>"Bandit", :size=>"Medium", :type=>"humanoid", :subtype=>"any race", :alignment=>"any non-lawful alignment", :armor_class=>12, :hit_points=>11, :hit_dice=>"2d8", :speed=>{:walk=>"30 ft."}, :strength=>11, :dexterity=>12, :constitution=>12, :intelligence=>10, :wisdom=>10, :charisma=>10, :proficiencies=>[], :damage_vulnerabilities=>[], :damage_resistances=>[], :damage_immunities=>[], :condition_immunities=>[], :senses=>{:passive_perception=>10}, :languages=>"any one language (usually Common)", :challenge_rating=>0.125, :xp=>25, :actions=>[{:name=>"Scimitar", :desc=>"Melee Weapon Attack: +3 to hit, reach 5 ft., one target. Hit: 4 (1d6 + 1) slashing damage.", :attack_bonus=>3, :damage=>[{:damage_type=>{:index=>"slashing", :name=>"Slashing", :url=>"/api/damage-types/slashing"}, :damage_dice=>"1d6+1"}]}, {:name=>"Light Crossbow", :desc=>"Ranged Weapon Attack: +3 to hit, range 80 ft./320 ft., one target. Hit: 5 (1d8 + 1) piercing damage.", :attack_bonus=>3, :damage=>[{:damage_type=>{:index=>"piercing", :name=>"Piercing", :url=>"/api/damage-types/piercing"}, :damage_dice=>"1d8+1"}]}], :url=>"/api/monsters/bandit"}
    # puts response[:speed].class

    # ability scores & modifiers
    abilities = %i[strength dexterity constitution intelligence wisdom charisma]
    ability_scores = abilities.to_h { |a| [a, response[a]] }
    # puts ability_scores
    ability_modifiers = abilities.to_h { |a| [a, ability_modifier(response[a])] }
    # puts ability_modifiers
    response
  end

  private

  def ability_modifier(score)
    (score - 10) / 2
  end
end
