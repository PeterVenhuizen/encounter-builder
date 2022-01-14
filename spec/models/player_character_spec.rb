require 'rails_helper'

RSpec.describe PlayerCharacter, type: :model do
  it 'is called Bob' do
    pc = PlayerCharacter.new(name: 'Bob')
    expect(pc.name).to eq 'Bob'
  end

  it 'is of level 1 by default' do
    pc = PlayerCharacter.new(name: 'Bob')
    expect(pc.level).to eq '1'
  end

  it 'can have a level between 1 and 20' do
    pc = PlayerCharacter.new(name: 'Bob', level: '8')
    expect(pc.level).to eq '8'
  end

  it 'cannot be of a level lower than 1' do
    expect { PlayerCharacter.new(name: 'Bob', level: '-1') }.to raise_error(ArgumentError)
  end

  it 'cannot be of a level higher than 20' do
    expect { PlayerCharacter.new(name: 'Bob', level: '21') }.to raise_error(ArgumentError)
  end

  it 'of level 1 has an easy XP threshold of 25' do
    pc = PlayerCharacter.new(name: 'Bob')
    expect(pc.xp_threshold(:easy)).to eq 25
  end

  it 'of level 2 knows its four XP thresholds' do
    pc = PlayerCharacter.new(name: 'Bob', level: '2')
    expect(pc.xp_threshold).to eq({ easy: 50, medium: 100, hard: 150, deadly: 200 })
  end
end
