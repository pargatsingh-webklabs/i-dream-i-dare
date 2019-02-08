require 'rails_helper'

RSpec.describe "resources/index", type: :view do
  before(:each) do
    assign(:resources, [
      Resource.create!(
        :title => "Title",
        :description => "MyText",
        :resource_string => "MyText",
        :resource_type_id => 1,
        :tag_1 => "Tag 1",
        :tag_2 => "Tag 2",
        :tag_3 => "Tag 3"
      ),
      Resource.create!(
        :title => "Title",
        :description => "MyText",
        :resource_string => "MyText",
        :resource_type_id => 1,
        :tag_1 => "Tag 1",
        :tag_2 => "Tag 2",
        :tag_3 => "Tag 3"
      )
    ])
  end

  it "renders a list of resources" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Tag 1".to_s, :count => 2
    assert_select "tr>td", :text => "Tag 2".to_s, :count => 2
    assert_select "tr>td", :text => "Tag 3".to_s, :count => 2
  end
end
