require 'rails_helper'

RSpec.describe "companies/show", type: :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      :logo_path => "Logo Path",
      :name => "Name",
      :description => "MyText",
      :logo_filename => "Logo Filename",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Logo Path/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Logo Filename/)
    expect(rendered).to match(/false/)
  end
end
