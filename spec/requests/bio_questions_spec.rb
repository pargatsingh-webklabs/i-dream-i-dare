require 'rails_helper'

RSpec.describe "BioQuestions", type: :request do
  describe "GET /bio_questions" do
    it "works! (now write some real specs)" do
      get bio_questions_path
      expect(response).to have_http_status(200)
    end
  end
end
