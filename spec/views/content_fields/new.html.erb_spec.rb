require 'rails_helper'

RSpec.describe "content_fields/new", type: :view do
  before(:each) do
    assign(:content_field, ContentField.new(
      :name => "MyString",
      :value => "MyString"
    ))
  end

  it "renders new content_field form" do
    render

    assert_select "form[action=?][method=?]", content_fields_path, "post" do

      assert_select "input#content_field_name[name=?]", "content_field[name]"

      assert_select "input#content_field_value[name=?]", "content_field[value]"
    end
  end
end
