require 'rails_helper'

RSpec.describe "bio_questions/show", type: :view do
  before(:each) do
    @bio_question = assign(:bio_question, BioQuestion.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
