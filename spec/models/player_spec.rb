require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:valid_attributes) do
    {
      name: 'Bob',
      level: 1
    }
  end

  before(:each) do
    @player = Player.new(valid_attributes)
  end

  it 'has a name' do
    @player.name = ''
    expect(@player).to_not be_valid
  end

  it 'has a name at least 2 characters long' do
    @player.name = 'A'
    expect(@player).to_not be_valid
  end

  it 'is at level 1 by default' do
    player = Player.new(name: 'Bob')
    expect(player.level).to eq 1
  end

  it 'cannot be of a level lower than 1' do
    @player.level = -1
    expect(@player).to_not be_valid
  end

  it 'cannot be of a level higher than 20' do
    @player.level = 21
    expect(@player).to_not be_valid
  end

  it 'can get a specific difficulty xp value' do
    expect(@player.xp(:easy)).to eq 25
  end

  it "can access it's xp" do
    expect(@player.xp).to eq({ easy: 25, medium: 50, hard: 75, deadly: 100 })
  end

  it 'belongs to a party'
end
