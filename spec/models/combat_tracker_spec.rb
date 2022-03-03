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

  it "it creates all the Combatants on create but not on find" do
    combatants = @combat_tracker.combatants
    expect(combatants.count).to eq 6
    expect(Combatant.count).to eq 6

    expect {
      CombatTracker.first
    }.to_not change(Combatant, :count)
  end

  it "combatants are ordered based on initiative" do
    combatant = @combat_tracker.combatants.fourth
    combatant.update_attribute(:initiative, 20)
    expect(@combat_tracker.combatants.first).to eq combatant
  end

  it "has a turn counter that goes back to one after the last combatant" do
    expect(@combat_tracker.turn).to eq 1
    6.times { @combat_tracker.next_turn }
    expect(@combat_tracker.turn).to eq 1
  end

  it "increases the round count at the start of a new round" do
    6.times { @combat_tracker.next_turn }
    expect(@combat_tracker.round).to eq 2
    expect(@combat_tracker.turn).to eq 1
  end

  it 'turn count corresponds to the active combatant' do
    expect(@combat_tracker.combatants.first.turn?).to be true
    @combat_tracker.next_turn
    active_combatant = @combat_tracker.active_combatant
    expect(@combat_tracker.combatants.second).to eq active_combatant
    expect(active_combatant.turn?).to be true
  end
end
