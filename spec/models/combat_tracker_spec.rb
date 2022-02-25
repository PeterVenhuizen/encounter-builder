require 'rails_helper'

RSpec.describe CombatTracker, type: :model do
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
    @encounter = party.encounters.create(encounter_attributes)
    @combat_tracker = @encounter.create_combat_tracker
  end

  it "the used Encounter should be valid" do
    expect(@encounter).to be_valid
    expect(@encounter.players.size).to eq 3
  end

  it "the CombatTracker should be valid" do
    expect(@combat_tracker).to be_valid
  end

  it "a new CombatTracker is in it's first round" do
    expect(@combat_tracker.round).to eq 1
  end

  it "it starts off on turn one" do
    expect(@combat_tracker.turn).to eq 1
  end

  it "it create all the Combatants on create but not on find" do
    combatants = @combat_tracker.combatants
    expect(combatants.count).to eq 6
    expect(Combatant.count).to eq 6
    expect(combatants).to eq(Combatant.all)

    expect {
      CombatTracker.first
    }.to_not change(Combatant, :count)
  end

  it "combatants are ordered based on initiative" do
    combatant = @combat_tracker.combatants.fourth
    expect(@combat_tracker.combatants.fourth).to eq combatant
    combatant.update_attribute(:initiative, 20)
    expect(@combat_tracker.combatants.first).to eq combatant
  end
end
