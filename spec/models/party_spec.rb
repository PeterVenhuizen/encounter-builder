require 'rails_helper'

RSpec.describe Party, type: :model do

  before(:each) do
    @party = Party.create(
      name: 'Team Rocket',
      players_attributes: [
        { name: 'Jessie', level: 1 },
        { name: 'James', level: 1 },
        { name: 'Meowth', level: 3 }
      ]
    )
  end

  it 'has a name' do
    @party.name = ''
    expect(@party).to_not be_valid
  end

  it 'has a name at least 2 characters long' do
    @party.name = 'Z'
    expect(@party).to_not be_valid
  end

  it 'has three players' do
    expect(@party.party_size).to eq 3
  end

  it 'accepts attributes for player addition'
  it 'cannot have the same player twice'

  it 'accepts attributes for player destroy' do
    @party.update(players_attributes: { id: @party.players.first.id, _destroy: true })
    expect(@party.party_size).to eq 2
  end

  it 'has an average player level of 5 / 3' do
    expect(@party.average_player_level).to eq 5 / 3.0
  end

  it 'reports the total party xp' do
    party_xp = @party.party_xp
    expect(party_xp[:easy]).to eq 125
    expect(party_xp[:medium]).to eq 250
    expect(party_xp[:hard]).to eq 375
    expect(party_xp[:deadly]).to eq 600
  end
end
