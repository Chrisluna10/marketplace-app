require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      name: "MyString",
      category: "MyText",
      price: 1,
      description: "MyText",
      user_id: 1
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input[name=?]", "item[name]"

      assert_select "textarea[name=?]", "item[category]"

      assert_select "input[name=?]", "item[price]"

      assert_select "textarea[name=?]", "item[description]"

      assert_select "input[name=?]", "item[user_id]"
    end
  end
end
