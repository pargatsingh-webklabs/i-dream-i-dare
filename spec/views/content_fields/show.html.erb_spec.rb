require 'rails_helper'

RSpec.describe "content_fields/show", type: :view do
  before(:each) do
    @content_field = assign(:content_field, ContentField.create!(
      :name => "Name",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Value/)
  end
end
