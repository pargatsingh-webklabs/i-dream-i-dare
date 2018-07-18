require 'rails_helper'

RSpec.describe "bio_questions/index", type: :view do
  before(:each) do
    assign(:bio_questions, [
      BioQuestion.create!(),
      BioQuestion.create!()
    ])
  end

  it "renders a list of bio_questions" do
    render
  end
end
