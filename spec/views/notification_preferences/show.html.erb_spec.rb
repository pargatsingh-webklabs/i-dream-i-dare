require 'rails_helper'

RSpec.describe "notification_preferences/show", type: :view do
  before(:each) do
    @notification_preference = assign(:notification_preference, NotificationPreference.create!(
      :notification_reason => "Notification Reason",
      :notification_type => "Notification Type",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Notification Reason/)
    expect(rendered).to match(/Notification Type/)
    expect(rendered).to match(/1/)
  end
end
