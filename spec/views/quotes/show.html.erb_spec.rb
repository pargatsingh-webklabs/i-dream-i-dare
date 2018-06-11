require 'rails_helper'

RSpec.describe "quotes/show", type: :view do
  before(:each) do
    @quote = assign(:quote, Quote.create!(
      :body => "MyText",
      :author => "Author",
      :url_for_image => "Url For Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/Url For Image/)
  end
end
