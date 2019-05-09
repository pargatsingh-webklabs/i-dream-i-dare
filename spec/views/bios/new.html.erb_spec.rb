require 'rails_helper'

RSpec.describe "bios/new", type: :view do
  before(:each) do
    assign(:bio, Bio.new(
      :user_id => 1,
      :profile_text => "MyString",
      :style_text => "MyString",
      :expertise => "MyString"
    ))
  end

  it "renders new bio form" do
    render

    assert_select "form[action=?][method=?]", bios_path, "post" do

      assert_select "input#bio_user_id[name=?]", "bio[user_id]"

      assert_select "input#bio_profile_text[name=?]", "bio[profile_text]"

      assert_select "input#bio_style_text[name=?]", "bio[style_text]"

      assert_select "input#bio_expertise[name=?]", "bio[expertise]"
    end
  end
end
