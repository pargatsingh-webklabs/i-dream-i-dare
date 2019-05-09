require 'rails_helper'

RSpec.describe "BioAnswers", type: :request do
  describe "GET /bio_answers" do
    it "works! (now write some real specs)" do
      get bio_answers_path
      expect(response).to have_http_status(200)
    end
  end
end
