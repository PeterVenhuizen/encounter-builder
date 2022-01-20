require 'rails_helper'

RSpec.describe Party, type: :model do
  before(:all) do
    @bob_lvl1 = PlayerCharacter.new(name: 'Bob', level: '1')
    @bob_lvl2 = PlayerCharacter.new(name: 'Bob', level: '2')
    @henk_lvl1 = PlayerCharacter.new(name: 'Henk', level: '1')
  end

  it 'has no PlayerCharacters by default' do
    party = Party.new
    expect(party.size).to eq 0
  end

  it 'can have players when created' do
    party = Party.new([@bob_lvl1, @bob_lvl2])
    expect(party.size).to eq 2
  end

  it 'cannot start out with the same player twice' do
    party = Party.new([@bob_lvl1, @bob_lvl1])
    expect(party.players).to eq [@bob_lvl1]
  end

  it 'can have players join to it' do
    party = Party.new
    party.join(@bob_lvl1)
    expect(party.players).to eq [@bob_lvl1]
  end

  it "can't have a player join twice" do
    party = Party.new([@henk_lvl1])
    party.join(@henk_lvl1)
    expect(party.players).to eq [@henk_lvl1]
  end

  it 'can have players leave' do
    party = Party.new([@bob_lvl1, @bob_lvl2])
    party.leave(@bob_lvl1)
    expect(party.players).to eq [@bob_lvl2]
  end

  it 'a party of one has the same xp thresholds as the player character' do
    party = Party.new([@bob_lvl1])
    party_xp = party.party_xp
    expect(party_xp).to eq @bob_lvl1.xp_threshold
  end

  it 'a party of two level one characters have their xp thresholds summed' do
    party = Party.new([@bob_lvl1, @henk_lvl1])
    party_xp = party.party_xp
    expect(party_xp).to eq({ easy: 50, medium: 100, hard: 150, deadly: 200 })
  end

  it 'of a level one and level two character has a hard xp threshold of 225' do
    party = Party.new([@bob_lvl2, @henk_lvl1])
    party_xp = party.party_xp
    expect(party_xp[:hard]).to eq 225
  end
end
