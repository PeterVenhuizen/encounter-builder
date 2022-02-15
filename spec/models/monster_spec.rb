require 'rails_helper'

RSpec.describe Monster, type: :model do
  # fixtures :monsters

  let(:valid_attributes) do
    {
      name: 'Bandit',
      size: 'Medium',
      species: 'Humanoid',
      alignment: 'any non-lawful alignment',
      armor_class: '12 (leather armor)',
      hit_points: 11,
      hit_dice: '2d8 + 2',
      ability_scores: {
        strength: 11,
        dexterity: 12,
        constitution: 12,
        intelligence: 10,
        wisdom: 10,
        charisma: 10
      },
      challenge_rating: '1/8',
      xp: 25,
      proficiency_bonus: 2
    }
  end

  # let(:valid_attributes) do
  #   monsters(:bandit)
  # end

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

  it 'has an integer xp value' do
    monster = Monster.new
    monster.xp = 'abc'
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

  it 'cannot be a giant' do
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

  it "can't have zero hit points" do
    monster = Monster.new(valid_attributes)
    monster.hit_points = 0
    expect(monster).to_not be_valid
  end

  it 'has hit dice' do
    monster = Monster.new(valid_attributes)
    monster.hit_dice = ''
    expect(monster).to_not be_valid
  end

  # it 'has 30 hit points' do
  #   monster = Monster.new(valid_attributes)
  #   monster.hit_points = '30'
  #   expect(monster).to be_valid
  # end



  it 'abc is not a valid hit dice value' do
    monster = Monster.new(valid_attributes)
    monster.hit_dice = 'abc'
    expect(monster).to_not be_valid
  end

  it 'hit dice can be just dice' do
    monster = Monster.new(valid_attributes)
    monster.hit_dice = '5d6'
    expect(monster).to be_valid
  end

  it 'hit dice can consist of dice minus something' do
    monster = Monster.new(valid_attributes)
    monster.hit_dice = '1d4 - 1'
    expect(monster).to be_valid
  end

  it 'hit dice can consist of dice plus something' do
    monster = Monster.new(valid_attributes)
    monster.hit_dice = '6d10 + 12'
    expect(monster).to be_valid
  end

  it 'has an alignment' do
    monster = Monster.new(valid_attributes)
    monster.alignment = ''
    expect(monster).to_not be_valid
  end

  it 'has a default proficiency bonus of two' do
    monster = Monster.new
    expect(monster.proficiency_bonus).to eq 2
  end
end
