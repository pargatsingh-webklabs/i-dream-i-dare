require 'rails_helper'

RSpec.describe "schedules/show", type: :view do
  before(:each) do
    @schedule = assign(:schedule, Schedule.create!(
      :frequency => "Frequency",
      :active => false,
      :task_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Frequency/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
  end
end
