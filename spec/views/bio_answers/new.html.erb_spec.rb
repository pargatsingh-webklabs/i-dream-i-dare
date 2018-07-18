require 'rails_helper'

RSpec.describe "bio_answers/new", type: :view do
  before(:each) do
    assign(:bio_answer, BioAnswer.new())
  end

  it "renders new bio_answer form" do
    render

    assert_select "form[action=?][method=?]", bio_answers_path, "post" do
    end
  end
end
