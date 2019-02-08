require 'rails_helper'

RSpec.describe "resources/show", type: :view do
  before(:each) do
    @resource = assign(:resource, Resource.create!(
      :title => "Title",
      :description => "MyText",
      :resource_string => "MyText",
      :resource_type_id => 1,
      :tag_1 => "Tag 1",
      :tag_2 => "Tag 2",
      :tag_3 => "Tag 3"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Tag 1/)
    expect(rendered).to match(/Tag 2/)
    expect(rendered).to match(/Tag 3/)
  end
end
