require 'rails_helper'

RSpec.describe Monster, type: :model do
  let(:valid_attributes) do
    {
      name: 'Animated Broom',
      size: 'Small',
      species: 'Construct',
      hit_points: '17 (5d6)',
      armor_class: '12',
      challenge_rating: '1/4'
    }
  end

  it 'has a name at least 2 characters long' do
    monster = Monster.new(valid_attributes)
    monster.name = ''
    expect(monster).to_not be_valid
    expect(monster.errors.messages[:name]).to eq ['must be at least 2 characters long']
  end

  it 'has a default challenge rating of zero' do
    monster = Monster.new
    expect(monster.challenge_rating).to eq '0'
  end

  it 'can only have a challenge rating between zero and thirty' do
    monster = Monster.new(valid_attributes)
    monster.challenge_rating = '-1'
    expect(monster).to_not be_valid

    monster.challenge_rating = '31'
    expect(monster).to_not be_valid

    monster.challenge_rating = '1 1/2'
    expect(monster).to_not be_valid
  end

  it 'with challenge rating of zero gives 10 XP' do
    monster = Monster.new(valid_attributes)
    monster.challenge_rating = '0'
    expect(monster.xp).to eq 10
  end

  it 'has a size' do
    monster = Monster.new(valid_attributes)
    monster.size = nil
    expect(monster).to_not be_valid
  end

  it 'is not a giant' do
    monster = Monster.new(valid_attributes)
    monster.size = 'Giant'
    expect(monster).to_not be_valid
  end

  it 'has a species' do
    monster = Monster.new(valid_attributes)
    monster.species = nil
    expect(monster).to_not be_valid
  end

  it 'can not be a zombie' do
    monster = Monster.new(valid_attributes)
    monster.species = 'Zombie'
    expect(monster).to_not be_valid
  end

  it 'has an armor class' do
    monster = Monster.new(valid_attributes)
    monster.armor_class = nil
    expect(monster).to_not be_valid
  end

  it 'has hit points' do
    monster = Monster.new(valid_attributes)
    monster.hit_points = nil
    expect(monster).to_not be_valid
  end

  it 'has 30 hit points' do
    monster = Monster.new(valid_attributes)
    monster.hit_points = '30'
    expect(monster).to be_valid
  end

  it '1 (1d4 - 1) is valid' do
    monster = Monster.new(valid_attributes)
    monster.hit_points = '1 (1d4 - 1)'
    expect(monster).to be_valid
  end

  it 'abc is not a valid hit points value' do
    monster = Monster.new(valid_attributes)
    monster.hit_points = 'abc'
    expect(monster).to_not be_valid
  end

  it 'it can have a value and dice' do
    monster = Monster.new(valid_attributes)
    monster.hit_points = '17 (5d6)'
    expect(monster).to be_valid
  end

  it 'can add more than a single digit number to the dice' do
    monster = Monster.new(valid_attributes)
    monster.hit_points = '45 (6d10 + 12)'
    expect(monster).to be_valid
  end
end
