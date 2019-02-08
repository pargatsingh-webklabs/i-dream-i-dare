require 'rails_helper'

RSpec.describe "bio_answers/show", type: :view do
  before(:each) do
    @bio_answer = assign(:bio_answer, BioAnswer.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
