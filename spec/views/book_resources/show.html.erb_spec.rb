require 'rails_helper'

RSpec.describe "book_resources/show", type: :view do
  before(:each) do
    @book_resource = assign(:book_resource, BookResource.create!(
      :resource_id => 1,
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
