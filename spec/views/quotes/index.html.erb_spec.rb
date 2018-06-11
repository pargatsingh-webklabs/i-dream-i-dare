require 'rails_helper'

RSpec.describe "quotes/index", type: :view do
  before(:each) do
    assign(:quotes, [
      Quote.create!(
        :body => "MyText",
        :author => "Author",
        :url_for_image => "Url For Image"
      ),
      Quote.create!(
        :body => "MyText",
        :author => "Author",
        :url_for_image => "Url For Image"
      )
    ])
  end

  it "renders a list of quotes" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Url For Image".to_s, :count => 2
  end
end
