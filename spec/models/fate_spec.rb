require 'rails_helper'

RSpec.describe Fate, type: :model do
  fixtures :monsters, :encounters

  before(:each) do
    @fate = Fate.new(
      {
        encounter_id: encounters(:two_bandits).id,
        monster_id: monsters(:bandit).id
      }
    )
  end

  it 'is valid' do
    expect(@fate).to be_valid
  end

  it 'has a default group size of one' do
    expect(@fate.group_size).to eq 1
  end

  it ':group_size must be positive' do
    @fate.group_size = -1
    expect(@fate).to_not be_valid
  end

  it ":group_size can't be zero" do
    @fate.group_size = 0
    expect(@fate).to_not be_valid
  end
end
