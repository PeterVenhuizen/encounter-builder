require 'rails_helper'

RSpec.describe Combatant, type: :model do
  fixtures :monsters, :parties, :players

  let(:encounter_attributes) do
    {
      name: 'Two bandits',
      description: 'Two bandits and a cat',
      fates_attributes: [
        { monster_id: monsters(:bandit).id, group_size: 2 },
        { monster_id: monsters(:cat).id }
      ]
    }
  end

  before(:each) do
    party = parties(:party_of_three)
    encounter = party.encounters.create(encounter_attributes)
    combat_tracker = encounter.create_combat_tracker
    @combatants = combat_tracker.combatants
    @player_combatant = Combatant.find_by(combatable_type: "Player")
    @monster_combatant = Combatant.find_by(combatable_type: "Monster")
  end

  it "can be a Player or a Monster" do
    expect(@combatants.size).to eq 6
    @combatants.each do |combatant|
      expect(combatant).to respond_to(:combatable)
    end
  end

  it "has a name" do
    @combatants.each do |combatant|
      expect(combatant).to respond_to(:name)
      expect(combatant).to be_an_instance_of(Combatant)
    end
  end

  it "knows when it is a Monster" do
    expect(@player_combatant.monster?).to be false
    expect(@monster_combatant.monster?).to be true
  end

  it "has an initiative higher than zero" do
    @player_combatant.initiative = -1
    expect(@player_combatant).to_not be_valid
  end

  it "has a turn when they are up" do
    expect(@player_combatant.turn).to eq false
    @player_combatant.turn = true
    expect(@player_combatant.turn?).to eq true
  end

  it "has hit points" do
    @combatants.each do |combatant|
      expect(combatant.hit_points).to eq 0
    end
  end

  it "is inactive with zero hit points" do
    expect(@player_combatant.inactive?).to be true

    @player_combatant.hit_points = 31
    expect(@player_combatant.inactive?).to be false
  end
end
