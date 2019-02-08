require 'rails_helper'

RSpec.describe "bio_questions/edit", type: :view do
  before(:each) do
    @bio_question = assign(:bio_question, BioQuestion.create!())
  end

  it "renders the edit bio_question form" do
    render

    assert_select "form[action=?][method=?]", bio_question_path(@bio_question), "post" do
    end
  end
end
