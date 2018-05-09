require 'rails_helper'

RSpec.describe "content_fields/index", type: :view do
  before(:each) do
    assign(:content_fields, [
      ContentField.create!(
        :name => "Name",
        :value => "Value"
      ),
      ContentField.create!(
        :name => "Name",
        :value => "Value"
      )
    ])
  end

  it "renders a list of content_fields" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
