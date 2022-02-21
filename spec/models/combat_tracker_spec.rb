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
    encounter = Encounter.new(encounter_attributes)
    @combat_tracker = CombatTracker.new(encounter)
  end

  it "the used Encounter should be valid" do
    encounter = Encounter.new(encounter_attributes)
    expect(encounter).to be_valid
  end

  it "the CombatTracker should be valid" do
    expect(@combat_tracker).to be_valid
  end
end
