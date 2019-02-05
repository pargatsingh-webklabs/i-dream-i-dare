require 'rails_helper'

RSpec.describe "schedules/new", type: :view do
  before(:each) do
    assign(:schedule, Schedule.new(
      :frequency => "MyString",
      :active => false,
      :task_id => 1
    ))
  end

  it "renders new schedule form" do
    render

    assert_select "form[action=?][method=?]", schedules_path, "post" do

      assert_select "input#schedule_frequency[name=?]", "schedule[frequency]"

      assert_select "input#schedule_active[name=?]", "schedule[active]"

      assert_select "input#schedule_task_id[name=?]", "schedule[task_id]"
    end
  end
end
