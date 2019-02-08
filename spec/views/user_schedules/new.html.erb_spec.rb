require 'rails_helper'

RSpec.describe "user_schedules/new", type: :view do
  before(:each) do
    assign(:user_schedule, UserSchedule.new(
      :user_id => "",
      :schedule_id => "",
      :completed => false
    ))
  end

  it "renders new user_schedule form" do
    render

    assert_select "form[action=?][method=?]", user_schedules_path, "post" do

      assert_select "input#user_schedule_user_id[name=?]", "user_schedule[user_id]"

      assert_select "input#user_schedule_schedule_id[name=?]", "user_schedule[schedule_id]"

      assert_select "input#user_schedule_completed[name=?]", "user_schedule[completed]"
    end
  end
end
