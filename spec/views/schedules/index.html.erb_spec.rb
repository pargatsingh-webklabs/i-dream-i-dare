require 'rails_helper'

RSpec.describe "schedules/index", type: :view do
  before(:each) do
    assign(:schedules, [
      Schedule.create!(
        :frequency => "Frequency",
        :active => false,
        :task_id => 1
      ),
      Schedule.create!(
        :frequency => "Frequency",
        :active => false,
        :task_id => 1
      )
    ])
  end

  it "renders a list of schedules" do
    render
    assert_select "tr>td", :text => "Frequency".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
