require 'rails_helper'

RSpec.describe "monsters/index", type: :view do
  before(:each) do
    assign(:monsters, [
      Monster.create!(
        name: "Name",
        size: "Size",
        type: "Type",
        armor_class: 2,
        hit_points: "Hit Points",
        challenge_rating: "Challenge Rating"
      ),
      Monster.create!(
        name: "Name",
        size: "Size",
        type: "Type",
        armor_class: 2,
        hit_points: "Hit Points",
        challenge_rating: "Challenge Rating"
      )
    ])
  end

  it "renders a list of monsters" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Size".to_s, count: 2
    assert_select "tr>td", text: "Type".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Hit Points".to_s, count: 2
    assert_select "tr>td", text: "Challenge Rating".to_s, count: 2
  end
end
