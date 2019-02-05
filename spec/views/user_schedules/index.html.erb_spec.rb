require 'rails_helper'

RSpec.describe "user_schedules/index", type: :view do
  before(:each) do
    assign(:user_schedules, [
      UserSchedule.create!(
        :user_id => "",
        :schedule_id => "",
        :completed => false
      ),
      UserSchedule.create!(
        :user_id => "",
        :schedule_id => "",
        :completed => false
      )
    ])
  end

  it "renders a list of user_schedules" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
