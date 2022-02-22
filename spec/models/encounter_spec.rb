require 'rails_helper'

RSpec.describe Encounter, type: :model do
  fixtures :monsters, :players

  before(:each) do
    @party_of_one = Party.create(name: 'Just Bob', players_attributes: [{name: 'Bob', level: 1}])
    @party_of_two = Party.create(name: 'Bob + Henk', players_attributes: [{name: 'Bob', level: 1}, {name: 'Henk', level: 1}])
    @party_of_six = Party.create(name: 'Five is the charm', players_attributes: 
      [
        {name: 'Bob', level: 1},
        {name: 'Henk', level: 1},
        {name: 'Toos', level: 1},
        {name: 'Mies', level: 1},
        {name: 'Jaap', level: 1},
        {name: 'Joop', level: 1}
      ]
    )

    @cat = monsters(:cat)
    @bandit = monsters(:bandit)
    @harpy = monsters(:harpy)
  end

  let(:valid_attributes) do
    {
      name: 'lorem',
      description: 'ipsum',
      party_id: @party_of_one.id,
      fates_attributes: [monster_id: @cat.id]
    }
  end

  it 'to be valid' do
    encounter = Encounter.new(valid_attributes)
    expect(encounter).to be_valid
  end

  it 'must have a name' do
    encounter = Encounter.new(valid_attributes)
    encounter.name = ''
    expect(encounter).to_not be_valid
  end

  it 'must have a description' do
    encounter = Encounter.new(valid_attributes)
    encounter.description = ''
    expect(encounter).to_not be_valid
  end

  it 'has players' do
    encounter = Encounter.new(valid_attributes)
    expect(encounter.players.size).to eq 1

    encounter.party_id = @party_of_six.id
    expect(encounter.players.size).to eq 6
  end

  it 'must have at least one fate' do
    encounter = Encounter.new(valid_attributes[:fates_attributes] = {})
    expect(encounter).to_not be_valid
  end

  it 'has a default stats' do
    stats = Encounter.new.calculate_statistics
    expect(stats[:multiplier]).to eq 1
    expect(stats[:difficulty]).to eq :none
    expect(stats[:total_experience]).to eq 0
    expect(stats[:adjusted_experience]).to eq 0
  end

  it 'with a cat and one level one player is trivial' do
    encounter = Encounter.new(valid_attributes)
    stats = encounter.calculate_statistics
    expect(stats[:multiplier]).to eq 1.5
    expect(stats[:difficulty]).to eq :trivial
    expect(stats[:total_experience]).to eq 10
    expect(stats[:adjusted_experience]).to eq 15
  end

  it 'with two bandits and one level one player is deadly' do
    valid_attributes[:fates_attributes] = [{ monster_id: @bandit.id, group_size: 2 }]
    encounter = Encounter.new(valid_attributes)
    stats = encounter.calculate_statistics
    expect(stats[:multiplier]).to eq 2
    expect(stats[:difficulty]).to eq :deadly
    expect(stats[:total_experience]).to eq 50
    expect(stats[:adjusted_experience]).to eq 100
  end

  it 'with two bandits and two level one players is medium' do
    valid_attributes[:fates_attributes] = [{ monster_id: @bandit.id, group_size: 2 }]
    encounter = Encounter.new(valid_attributes)
    encounter.party_id = @party_of_two.id
    stats = encounter.calculate_statistics
    expect(stats[:multiplier]).to eq 2
    expect(stats[:difficulty]).to eq :medium
    expect(stats[:total_experience]).to eq 50
    expect(stats[:adjusted_experience]).to eq 100
  end

  it 'with six players and two harpies is medium' do
    valid_attributes[:fates_attributes] = [{ monster_id: @harpy.id, group_size: 2 }]
    encounter = Encounter.new(valid_attributes)
    encounter.party_id = @party_of_six.id
    stats = encounter.calculate_statistics
    expect(stats[:multiplier]).to eq 1
    expect(stats[:difficulty]).to eq :medium
    expect(stats[:total_experience]).to eq 400
    expect(stats[:adjusted_experience]).to eq 400
  end

  context "when encounter is not created" do
    it "stats column is an empty hash" do
      encounter = Encounter.new
      expect(encounter.stats).to eq ({})
    end
  end

  context "when encounter is created" do
    it "stats column is populated" do
      encounter = Encounter.create(valid_attributes)
      expect(encounter.stats).to eq ({ 'multiplier' => 1.5, 
                                       'difficulty' => 'trivial', 
                                       'total_experience' => 10, 
                                       'adjusted_experience' => 15 })
    end
  end
end
