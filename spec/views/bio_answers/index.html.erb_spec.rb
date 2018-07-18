require 'rails_helper'

RSpec.describe "bio_answers/index", type: :view do
  before(:each) do
    assign(:bio_answers, [
      BioAnswer.create!(),
      BioAnswer.create!()
    ])
  end

  it "renders a list of bio_answers" do
    render
  end
end
