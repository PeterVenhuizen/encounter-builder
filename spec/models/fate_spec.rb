require 'rails_helper'

RSpec.describe Fate, type: :model do
  it 'has a default group size of one' do
    fate = Fate.new
    expect(fate.group_size).to eq 1
  end

  it 'cannot have a negative group size'
end
