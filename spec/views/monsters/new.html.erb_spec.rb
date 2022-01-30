require 'rails_helper'

RSpec.describe "monsters/new", type: :view do
  before(:each) do
    assign(:monster, Monster.new(
      name: "MyString",
      size: "MyString",
      species: "MyString",
      armor_class: "MyString",
      hit_points: "MyString",
      challenge_rating: "MyString"
    ))
  end

  it "renders new monster form" do
    render

    assert_select "form[action=?][method=?]", monsters_path, "post" do

      assert_select "input[name=?]", "monster[name]"

      assert_select "input[name=?]", "monster[size]"

      assert_select "input[name=?]", "monster[species]"

      assert_select "input[name=?]", "monster[armor_class]"

      assert_select "input[name=?]", "monster[hit_points]"

      assert_select "input[name=?]", "monster[challenge_rating]"
    end
  end
end
