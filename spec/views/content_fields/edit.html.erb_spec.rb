require 'rails_helper'

RSpec.describe "content_fields/edit", type: :view do
  before(:each) do
    @content_field = assign(:content_field, ContentField.create!(
      :name => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit content_field form" do
    render

    assert_select "form[action=?][method=?]", content_field_path(@content_field), "post" do

      assert_select "input#content_field_name[name=?]", "content_field[name]"

      assert_select "input#content_field_value[name=?]", "content_field[value]"
    end
  end
end
