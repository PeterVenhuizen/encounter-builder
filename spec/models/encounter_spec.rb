require 'rails_helper'

RSpec.describe Encounter, type: :model do
  before(:each) do
    @party_of_one = Party.new([PlayerCharacter.new('Bob', 1)])
    @party_of_two = Party.new([PlayerCharacter.new('Bob', 1), PlayerCharacter.new('Henk', 1)])
    @party_of_five = Party.new([
                                 PlayerCharacter.new('Bob', 1),
                                 PlayerCharacter.new('Henk', 1),
                                 PlayerCharacter.new('Toos', 1),
                                 PlayerCharacter.new('Mies', 1),
                                 PlayerCharacter.new('Jaap', 1)
                               ])

    @cat = Monster.new('Cat', 0)
    @bandit = Monster.new('Bandit', 0.125)
    @harpy = Monster.new('Harpy', 1)
  end

  it 'has an empty party by default' do
    encounter = Encounter.new
    expect(encounter.party).to be_a Party
    expect(encounter.party.size).to eq 0
  end

  it 'can have monsters added to it' do
    encounter = Encounter.new
    encounter.add_monster(@cat)
    expect(encounter.monsters).to eq [@cat]
  end

  it 'without any monsters awards zero xp' do
    encounter = Encounter.new
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.award_xp).to eq 0
  end

  it 'without any players has an adjusted xp of zero' do
    encounter = Encounter.new
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.adjusted_xp).to eq 0
  end

  it 'without any monsters has a multiplier of one' do
    encounter = Encounter.new
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.multiplier).to eq 1
  end

  it 'without any monsters has a difficulty of easy' do
    encounter = Encounter.new
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.difficulty).to eq :easy
  end

  it 'with a cat and a party of one is easy' do
    encounter = Encounter.new(@party_of_one, [@cat])
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.award_xp).to eq 10
    expect(encounter_dto.adjusted_xp).to eq 15
    expect(encounter_dto.multiplier).to eq 1.5
    expect(encounter_dto.difficulty).to eq :easy
  end

  it 'with two bandits and one level one player character is deadly' do
    encounter = Encounter.new(@party_of_one, [@bandit, Monster.new('Bandit', 0.125)])
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.award_xp).to eq 50
    expect(encounter_dto.adjusted_xp).to eq 100
    expect(encounter_dto.multiplier).to eq 2
    expect(encounter_dto.difficulty).to eq :deadly
  end

  it 'with two bandits and two level one player characters is of medium difficulty' do
    encounter = Encounter.new(@party_of_two, [@bandit, Monster.new('Bandit', 0.125)])
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.award_xp).to eq 50
    expect(encounter_dto.adjusted_xp).to eq 100
    expect(encounter_dto.multiplier).to eq 2
    expect(encounter_dto.difficulty).to eq :medium
  end

  it 'with five players and two harpies is deadly' do
    encounter = Encounter.new(@party_of_five, [@harpy, Monster.new('Harpy', 1)])
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.award_xp).to eq 400
    expect(encounter_dto.adjusted_xp).to eq 600
    expect(encounter_dto.multiplier).to eq 1.5
    expect(encounter_dto.difficulty).to eq :deadly
  end

  it 'with six players and two harpies is of medium difficulty' do
    encounter = Encounter.new(@party_of_five, [@harpy, Monster.new('Harpy', 1)])
    encounter.party.join(PlayerCharacter.new('Held', 1))
    encounter_dto = encounter.calculate_difficulty
    expect(encounter_dto.award_xp).to eq 400
    expect(encounter_dto.adjusted_xp).to eq 400
    expect(encounter_dto.multiplier).to eq 1
    expect(encounter_dto.difficulty).to eq :medium
  end
end
