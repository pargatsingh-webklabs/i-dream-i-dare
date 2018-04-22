require 'rails_helper'

RSpec.describe "notification_preferences/index", type: :view do
  before(:each) do
    assign(:notification_preferences, [
      NotificationPreference.create!(
        :notification_reason => "Notification Reason",
        :notification_type => "Notification Type",
        :user_id => 1
      ),
      NotificationPreference.create!(
        :notification_reason => "Notification Reason",
        :notification_type => "Notification Type",
        :user_id => 1
      )
    ])
  end

  it "renders a list of notification_preferences" do
    render
    assert_select "tr>td", :text => "Notification Reason".to_s, :count => 2
    assert_select "tr>td", :text => "Notification Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
