require 'rails_helper'

RSpec.describe "notification_preferences/edit", type: :view do
  before(:each) do
    @notification_preference = assign(:notification_preference, NotificationPreference.create!(
      :notification_reason => "MyString",
      :notification_type => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit notification_preference form" do
    render

    assert_select "form[action=?][method=?]", notification_preference_path(@notification_preference), "post" do

      assert_select "input#notification_preference_notification_reason[name=?]", "notification_preference[notification_reason]"

      assert_select "input#notification_preference_notification_type[name=?]", "notification_preference[notification_type]"

      assert_select "input#notification_preference_user_id[name=?]", "notification_preference[user_id]"
    end
  end
end
