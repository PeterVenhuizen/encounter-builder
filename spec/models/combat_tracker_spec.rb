require 'rails_helper'

RSpec.describe CombatTracker, type: :model do
  fixtures :monsters, :parties

  let(:encounter_attributes) do
    {
      name: 'Two bandits',
      description: 'Two bandits and a cat',
      party_id: parties(:party_of_three).id,
      fates_attributes: [
        { monster_id: monsters(:bandit).id, group_size: 2 },
        { monster_id: monsters(:cat).id }
      ]
    }
  end

  before(:each) do
    @encounter = Encounter.create(encounter_attributes)
    @combat_tracker = @encounter.create_combat_tracker
  end

  it "the used Encounter should be valid" do
    expect(@encounter).to be_valid
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

  it "contains all the Combatants in the Encounter" do
    combatants = @combat_tracker.combatants
    expect(combatants.size).to eq 6
    expect(Combatant.count).to eq 6
  end

  it "should create the combatants"
  it "should only create the combatants once"
end
