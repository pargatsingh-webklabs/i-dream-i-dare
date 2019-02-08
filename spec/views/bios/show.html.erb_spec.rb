require 'rails_helper'

RSpec.describe "bios/show", type: :view do
  before(:each) do
    @bio = assign(:bio, Bio.create!(
      :user_id => 1,
      :profile_text => "Profile Text",
      :style_text => "Style Text",
      :expertise => "Expertise"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Profile Text/)
    expect(rendered).to match(/Style Text/)
    expect(rendered).to match(/Expertise/)
  end
end
