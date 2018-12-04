require 'rails_helper'

RSpec.describe "BookResources", type: :request do
  describe "GET /book_resources" do
    it "works! (now write some real specs)" do
      get book_resources_path
      expect(response).to have_http_status(200)
    end
  end
end
