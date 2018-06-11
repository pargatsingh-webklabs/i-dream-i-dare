require 'rails_helper'

RSpec.describe "quotes/new", type: :view do
  before(:each) do
    assign(:quote, Quote.new(
      :body => "MyText",
      :author => "MyString",
      :url_for_image => "MyString"
    ))
  end

  it "renders new quote form" do
    render

    assert_select "form[action=?][method=?]", quotes_path, "post" do

      assert_select "textarea#quote_body[name=?]", "quote[body]"

      assert_select "input#quote_author[name=?]", "quote[author]"

      assert_select "input#quote_url_for_image[name=?]", "quote[url_for_image]"
    end
  end
end
