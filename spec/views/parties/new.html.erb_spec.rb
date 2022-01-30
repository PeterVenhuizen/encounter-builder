require 'rails_helper'

RSpec.describe "parties/new", type: :view do
  before(:each) do
    assign(:party, Party.new(
      name: "MyString"
    ))
  end

  it "renders new party form" do
    render

    assert_select "form[action=?][method=?]", parties_path, "post" do

      assert_select "input[name=?]", "party[name]"
    end
  end
end
