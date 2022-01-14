require 'rails_helper'

RSpec.describe Monster, type: :model do
  it 'has a empty name by default' do
    monster = Monster.new
    expect(monster.name.size).to eq 0
  end

  it 'has a name' do
    monster = Monster.new('Cat')
    expect(monster.name).to eq 'Cat'
  end

  it 'has a challenge rating of zero by default' do
    monster = Monster.new
    expect(monster.cr).to eq 0
  end

  it "can't have a challenge rating below zero" do
    expect { Monster.new('Negatory', -1) }.to raise_error(ArgumentError)
  end

  it "can't have a challenge rating above 30" do
    expect { Monster.new('Too Powerfull', 31) }.to raise_error(ArgumentError)
  end

  it "can't have an unknown challenge rating" do
    expect { Monster.new('One and a Half Monster', 1.5) }.to raise_error(ArgumentError)
  end

  it 'of CR zero gives 10 XP' do
    monster = Monster.new('Cat', 0)
    expect(monster.xp).to eq 10
  end

  it 'Frog gives 0 XP' do
    monster = Monster.new('Frog', 0, 0)
    expect(monster.xp).to eq 0
  end

  it 'Terrasque gives 155_000 XP' do
    monster = Monster.new('Terrasque', 30)
    expect(monster.xp).to eq 155_000
  end
end
