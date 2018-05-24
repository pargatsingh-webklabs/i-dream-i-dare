require 'rails_helper'

RSpec.describe "bios/edit", type: :view do
  before(:each) do
    @bio = assign(:bio, Bio.create!(
      :user_id => 1,
      :profile_text => "MyString",
      :style_text => "MyString",
      :expertise => "MyString"
    ))
  end

  it "renders the edit bio form" do
    render

    assert_select "form[action=?][method=?]", bio_path(@bio), "post" do

      assert_select "input#bio_user_id[name=?]", "bio[user_id]"

      assert_select "input#bio_profile_text[name=?]", "bio[profile_text]"

      assert_select "input#bio_style_text[name=?]", "bio[style_text]"

      assert_select "input#bio_expertise[name=?]", "bio[expertise]"
    end
  end
end
