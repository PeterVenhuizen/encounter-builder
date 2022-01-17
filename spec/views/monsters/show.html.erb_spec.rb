require 'rails_helper'

RSpec.describe "monsters/show", type: :view do
  before(:each) do
    @monster = assign(:monster, Monster.create!(
      name: "Name",
      size: "Size",
      type: "Type",
      armor_class: 2,
      hit_points: "Hit Points",
      challenge_rating: "Challenge Rating"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Size/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Hit Points/)
    expect(rendered).to match(/Challenge Rating/)
  end
end
