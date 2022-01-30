require 'rails_helper'

RSpec.describe "parties/index", type: :view do
  before(:each) do
    assign(:parties, [
      Party.create!(
        name: "Name"
      ),
      Party.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of parties" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
