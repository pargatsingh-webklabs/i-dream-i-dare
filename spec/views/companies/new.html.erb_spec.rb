require 'rails_helper'

RSpec.describe "companies/new", type: :view do
  before(:each) do
    assign(:company, Company.new(
      :logo_path => "MyString",
      :name => "MyString",
      :description => "MyText",
      :logo_filename => "MyString",
      :active => false
    ))
  end

  it "renders new company form" do
    render

    assert_select "form[action=?][method=?]", companies_path, "post" do

      assert_select "input#company_logo_path[name=?]", "company[logo_path]"

      assert_select "input#company_name[name=?]", "company[name]"

      assert_select "textarea#company_description[name=?]", "company[description]"

      assert_select "input#company_logo_filename[name=?]", "company[logo_filename]"

      assert_select "input#company_active[name=?]", "company[active]"
    end
  end
end
