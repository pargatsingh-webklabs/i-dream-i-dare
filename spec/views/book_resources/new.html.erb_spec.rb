require 'rails_helper'

RSpec.describe "book_resources/new", type: :view do
  before(:each) do
    assign(:book_resource, BookResource.new(
      :resource_id => 1,
      :active => false
    ))
  end

  it "renders new book_resource form" do
    render

    assert_select "form[action=?][method=?]", book_resources_path, "post" do

      assert_select "input#book_resource_resource_id[name=?]", "book_resource[resource_id]"

      assert_select "input#book_resource_active[name=?]", "book_resource[active]"
    end
  end
end
