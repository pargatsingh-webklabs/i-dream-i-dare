require 'rails_helper'

RSpec.describe "bio_questions/new", type: :view do
  before(:each) do
    assign(:bio_question, BioQuestion.new())
  end

  it "renders new bio_question form" do
    render

    assert_select "form[action=?][method=?]", bio_questions_path, "post" do
    end
  end
end
