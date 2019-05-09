require 'rails_helper'

RSpec.describe "NotificationPreferences", type: :request do
  describe "GET /notification_preferences" do
    it "works! (now write some real specs)" do
      get notification_preferences_path
      expect(response).to have_http_status(200)
    end
  end
end
