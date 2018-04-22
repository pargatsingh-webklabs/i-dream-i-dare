require 'rails_helper'

RSpec.describe "notification_preferences/new", type: :view do
  before(:each) do
    assign(:notification_preference, NotificationPreference.new(
      :notification_reason => "MyString",
      :notification_type => "MyString",
      :user_id => 1
    ))
  end

  it "renders new notification_preference form" do
    render

    assert_select "form[action=?][method=?]", notification_preferences_path, "post" do

      assert_select "input#notification_preference_notification_reason[name=?]", "notification_preference[notification_reason]"

      assert_select "input#notification_preference_notification_type[name=?]", "notification_preference[notification_type]"

      assert_select "input#notification_preference_user_id[name=?]", "notification_preference[user_id]"
    end
  end
end
