require 'rails_helper'

RSpec.describe "book_resources/index", type: :view do
  before(:each) do
    assign(:book_resources, [
      BookResource.create!(
        :resource_id => 1,
        :active => false
      ),
      BookResource.create!(
        :resource_id => 1,
        :active => false
      )
    ])
  end

  it "renders a list of book_resources" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
