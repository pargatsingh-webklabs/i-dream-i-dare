require 'rails_helper'

RSpec.describe "book_resources/edit", type: :view do
  before(:each) do
    @book_resource = assign(:book_resource, BookResource.create!(
      :resource_id => 1,
      :active => false
    ))
  end

  it "renders the edit book_resource form" do
    render

    assert_select "form[action=?][method=?]", book_resource_path(@book_resource), "post" do

      assert_select "input#book_resource_resource_id[name=?]", "book_resource[resource_id]"

      assert_select "input#book_resource_active[name=?]", "book_resource[active]"
    end
  end
end
