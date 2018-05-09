require 'rails_helper'

RSpec.describe "ContentFields", type: :request do
  describe "GET /content_fields" do
    it "works! (now write some real specs)" do
      get content_fields_path
      expect(response).to have_http_status(200)
    end
  end
end
