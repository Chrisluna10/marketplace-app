require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        name: "Name",
        category: "MyText",
        price: 2,
        description: "MyText",
        user_id: 3
      ),
      Item.create!(
        name: "Name",
        category: "MyText",
        price: 2,
        description: "MyText",
        user_id: 3
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end
