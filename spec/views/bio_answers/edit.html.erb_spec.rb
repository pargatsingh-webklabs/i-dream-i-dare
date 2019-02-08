require 'rails_helper'

RSpec.describe "bio_answers/edit", type: :view do
  before(:each) do
    @bio_answer = assign(:bio_answer, BioAnswer.create!())
  end

  it "renders the edit bio_answer form" do
    render

    assert_select "form[action=?][method=?]", bio_answer_path(@bio_answer), "post" do
    end
  end
end
