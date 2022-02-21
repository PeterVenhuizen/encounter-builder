require 'rails_helper'

RSpec.describe Combatant, type: :model do
  fixtures :monsters, :players

  let(:valid_attributes) do
    {
      parent: players(:henk),
      initiative: 13
    }
  end

  before(:each) do
    @player = players(:henk)
    @monster = monsters(:bandit)
    @combatant = Combatant.new(valid_attributes)
  end

  it "is valid with a Player" do
    expect(@combatant).to be_valid
  end

  it "is valid with a Monster" do
    @combatant.parent = @monster
    expect(@combatant).to be_valid
  end

  it "has a name" do
    expect(@combatant.name).to eq 'Henk'

    @combatant.parent = @monster
    expect(@combatant.name).to eq 'Bandit'
  end

  it "knows when it is a Monster" do
    expect(@combatant.monster?).to be false

    @combatant.parent = @monster
    expect(@combatant.monster?).to be true
  end

  it "has an initiative higher than zero" do
    @combatant.initiative = -1
    expect(@combatant).to_not be_valid
  end

  it "has a turn when they are up" do
    expect(@combatant.turn).to eq false
    @combatant.turn = true
    expect(@combatant.turn?).to eq true
  end

  it "has hit points" do
    expect(@combatant.hit_points).to eq 0
  end

  it "is inactive with zero hit points" do
    expect(@combatant.inactive?).to be true

    @combatant.hit_points = 31
    expect(@combatant.inactive?).to be false
  end
end
