require 'rails_helper'

RSpec.describe "resources/new", type: :view do
  before(:each) do
    assign(:resource, Resource.new(
      :title => "MyString",
      :description => "MyText",
      :resource_string => "MyText",
      :resource_type_id => 1,
      :tag_1 => "MyString",
      :tag_2 => "MyString",
      :tag_3 => "MyString"
    ))
  end

  it "renders new resource form" do
    render

    assert_select "form[action=?][method=?]", resources_path, "post" do

      assert_select "input#resource_title[name=?]", "resource[title]"

      assert_select "textarea#resource_description[name=?]", "resource[description]"

      assert_select "textarea#resource_resource_string[name=?]", "resource[resource_string]"

      assert_select "input#resource_resource_type_id[name=?]", "resource[resource_type_id]"

      assert_select "input#resource_tag_1[name=?]", "resource[tag_1]"

      assert_select "input#resource_tag_2[name=?]", "resource[tag_2]"

      assert_select "input#resource_tag_3[name=?]", "resource[tag_3]"
    end
  end
end
