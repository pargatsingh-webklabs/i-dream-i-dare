require 'rails_helper'

RSpec.describe "user_schedules/show", type: :view do
  before(:each) do
    @user_schedule = assign(:user_schedule, UserSchedule.create!(
      :user_id => "",
      :schedule_id => "",
      :completed => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
