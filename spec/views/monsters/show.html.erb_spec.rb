require 'rails_helper'

RSpec.describe "monsters/show", type: :view do
  before(:each) do
    @monster = assign(:monster, Monster.create!(
      name: "Name",
      size: "Size",
      species: "Species",
      armor_class: "Armor Class",
      hit_points: "Hit Points",
      challenge_rating: "Challenge Rating"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Size/)
    expect(rendered).to match(/Species/)
    expect(rendered).to match(/Armor Class/)
    expect(rendered).to match(/Hit Points/)
    expect(rendered).to match(/Challenge Rating/)
  end
end
