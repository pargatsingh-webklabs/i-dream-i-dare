require 'rails_helper'

RSpec.describe "schedules/edit", type: :view do
  before(:each) do
    @schedule = assign(:schedule, Schedule.create!(
      :frequency => "MyString",
      :active => false,
      :task_id => 1
    ))
  end

  it "renders the edit schedule form" do
    render

    assert_select "form[action=?][method=?]", schedule_path(@schedule), "post" do

      assert_select "input#schedule_frequency[name=?]", "schedule[frequency]"

      assert_select "input#schedule_active[name=?]", "schedule[active]"

      assert_select "input#schedule_task_id[name=?]", "schedule[task_id]"
    end
  end
end
