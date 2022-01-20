require 'rails_helper'

RSpec.describe EncounterCalculator, type: :model do
  before(:all) do
    @party_of_one = Party.new([PlayerCharacter.new(name: 'Bob', level: '1')])
    @party_of_two = Party.new([PlayerCharacter.new(name: 'Bob', level: '1'), PlayerCharacter.new(name: 'Henk', level: '1')])
    @party_of_five = Party.new([
                                 PlayerCharacter.new(name: 'Bob', level: '1'),
                                 PlayerCharacter.new(name: 'Henk', level: '1'),
                                 PlayerCharacter.new(name: 'Toos', level: '1'),
                                 PlayerCharacter.new(name: 'Mies', level: '1'),
                                 PlayerCharacter.new(name: 'Jaap', level: '1')
                               ])

    @homunculus = Monster.new(name: 'Homunculus', challenge_rating: '0') # CR 0
    @slaad_tadpole = Monster.new(name: 'Slaad Tadpole', challenge_rating: '1/8') # CR 1/8
    @quasit = Monster.new(name: 'Quasit', challenge_rating: '1') # CR 1
  end

  it 'has an empty party by default' do
    encounter = EncounterCalculator.new
    expect(encounter.party).to be_a Party
    expect(encounter.party.size).to eq 0
  end

  it 'can have monsters added to it' do
    encounter = EncounterCalculator.new
    encounter.add_monster(@homunculus)
    expect(encounter.monsters).to eq [@homunculus]
  end

  it 'grants zero award xp without any monsters' do
    encounter = EncounterCalculator.new
    summary = encounter.summary
    expect(summary[:award_xp]).to eq 0
  end

  it 'has an adjusted xp of zero without any players' do
    encounter = EncounterCalculator.new
    summary = encounter.summary
    expect(summary[:adjusted_xp]).to eq 0
  end

  it 'has a multiplier of one by default' do
    encounter = EncounterCalculator.new
    summary = encounter.summary
    expect(summary[:multiplier]).to eq 1
  end

  it 'has a default difficulty of none without any players or monsters' do
    encounter = EncounterCalculator.new
    summary = encounter.summary
    expect(summary[:difficulty]).to eq :none
  end

  it 'with a homunculus and a party of one is trivial' do
    encounter = EncounterCalculator.new(@party_of_one, [@homunculus])
    summary = encounter.summary
    expect(summary[:award_xp]).to eq 10
    expect(summary[:adjusted_xp]).to eq 15
    expect(summary[:multiplier]).to eq 1.5
    expect(summary[:difficulty]).to eq :trivial
  end

  it 'with a two homunculi and a party of one is trivial' do
    encounter = EncounterCalculator.new(@party_of_one, [@homunculus, @homunculus])
    summary = encounter.summary
    expect(summary[:award_xp]).to eq 20
    expect(summary[:adjusted_xp]).to eq 40
    expect(summary[:multiplier]).to eq 2
    expect(summary[:difficulty]).to eq :easy
  end

  it 'with a two slaad tadpoles and a party of one is deadly' do
    encounter = EncounterCalculator.new(@party_of_one, [@slaad_tadpole, @slaad_tadpole])
    summary = encounter.summary
    expect(summary[:award_xp]).to eq 50
    expect(summary[:adjusted_xp]).to eq 100
    expect(summary[:multiplier]).to eq 2
    expect(summary[:difficulty]).to eq :deadly
  end

  it 'with a two slaad tadpoles and a party of two is of medium difficulty' do
    encounter = EncounterCalculator.new(@party_of_two, [@slaad_tadpole, @slaad_tadpole])
    summary = encounter.summary
    expect(summary[:difficulty]).to eq :medium
  end

  it 'with a party of five and two quasits is deadly' do
    encounter = EncounterCalculator.new(@party_of_five, [@quasit, @quasit])
    summary = encounter.summary
    expect(summary[:award_xp]).to eq 400
    expect(summary[:adjusted_xp]).to eq 600
    expect(summary[:multiplier]).to eq 1.5
    expect(summary[:difficulty]).to eq :deadly
  end

  it 'with a party of six and two quasits is deadly' do
    encounter = EncounterCalculator.new(@party_of_five, [@quasit, @quasit])
    encounter.party.join(PlayerCharacter.new(name: 'Anna', level: '1'))
    summary = encounter.summary
    expect(summary[:award_xp]).to eq 400
    expect(summary[:adjusted_xp]).to eq 400
    expect(summary[:multiplier]).to eq 1
    expect(summary[:difficulty]).to eq :medium
  end
end
