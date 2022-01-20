require 'rails_helper'

RSpec.describe Encounter, type: :model do
  let(:valid_attributes) do
    {
      name: 'My encounter',
      description: 'A short description',
      monsters: ['2d2f38f8-c463-4370-a6af-47c5c262131a']
    }
  end

  before(:each) do
    @encounter = Encounter.new(valid_attributes)
  end

  it 'has a name' do
    @encounter.name = ''
    expect(@encounter).to_not be_valid
  end

  it 'has a body at least 10 characters long' do
    @encounter.description = 'Too short'
    expect(@encounter).to_not be_valid
  end

  it 'has at least one monster' do
    @encounter.monsters = []
    expect(@encounter).to_not be_valid
    expect(@encounter.errors.messages[:monsters]).to eq ['the encounter should have at least one']
  end

  it 'only has monster uuids that are in the monster table'
end
