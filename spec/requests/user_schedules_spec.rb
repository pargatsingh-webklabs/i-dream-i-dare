require 'rails_helper'

RSpec.describe "UserSchedules", type: :request do
  describe "GET /user_schedules" do
    it "works! (now write some real specs)" do
      get user_schedules_path
      expect(response).to have_http_status(200)
    end
  end
end
