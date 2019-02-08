require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  before(:each) do
    assign(:companies, [
      Company.create!(
        :logo_path => "Logo Path",
        :name => "Name",
        :description => "MyText",
        :logo_filename => "Logo Filename",
        :active => false
      ),
      Company.create!(
        :logo_path => "Logo Path",
        :name => "Name",
        :description => "MyText",
        :logo_filename => "Logo Filename",
        :active => false
      )
    ])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", :text => "Logo Path".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Logo Filename".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
