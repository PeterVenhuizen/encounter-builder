require 'rails_helper'

RSpec.describe Monster, type: :model do
  it 'has a empty name by default' do
    monster = Monster.new
    expect(monster.name).to eq ''
  end

  it 'has a name' do
    monster = Monster.new(name: 'Cat')
    expect(monster.name).to eq 'Cat'
  end

  it 'has a challenge rating of zero by default' do
    monster = Monster.new
    expect(monster.cr).to eq '0'
  end

  it "can't have a challenge rating below zero" do
    expect { Monster.new(name: 'Negatory', cr: '-1') }.to raise_error(ArgumentError)
  end

  it "can't have a challenge rating above 30" do
    expect { Monster.new(name: 'Too Powerfull', cr: '31') }.to raise_error(ArgumentError)
  end

  it "can't have an unknown challenge rating" do
    expect { Monster.new(name: 'One and a Half Monster', cr: '1 1/2') }.to raise_error(ArgumentError)
  end

  it 'of CR zero gives 10 XP' do
    monster = Monster.new(name: 'Cat', cr: '0')
    expect(monster.xp).to eq 10
  end

  it 'Frog gives 0 XP' do
    monster = Monster.new(name: 'Frog', cr: '0', xp: 0)
    expect(monster.xp).to eq 0
  end

  it 'Terrasque gives 155_000 XP' do
    monster = Monster.new(name: 'Terrasque', cr: '30')
    expect(monster.xp).to eq 155_000
  end
end
