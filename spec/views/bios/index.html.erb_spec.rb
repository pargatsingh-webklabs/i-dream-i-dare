require 'rails_helper'

RSpec.describe "bios/index", type: :view do
  before(:each) do
    assign(:bios, [
      Bio.create!(
        :user_id => 1,
        :profile_text => "Profile Text",
        :style_text => "Style Text",
        :expertise => "Expertise"
      ),
      Bio.create!(
        :user_id => 1,
        :profile_text => "Profile Text",
        :style_text => "Style Text",
        :expertise => "Expertise"
      )
    ])
  end

  it "renders a list of bios" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Profile Text".to_s, :count => 2
    assert_select "tr>td", :text => "Style Text".to_s, :count => 2
    assert_select "tr>td", :text => "Expertise".to_s, :count => 2
  end
end
