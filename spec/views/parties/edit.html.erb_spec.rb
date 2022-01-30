require 'rails_helper'

RSpec.describe "parties/edit", type: :view do
  before(:each) do
    @party = assign(:party, Party.create!(
      name: "MyString"
    ))
  end

  it "renders the edit party form" do
    render

    assert_select "form[action=?][method=?]", party_path(@party), "post" do

      assert_select "input[name=?]", "party[name]"
    end
  end
end
