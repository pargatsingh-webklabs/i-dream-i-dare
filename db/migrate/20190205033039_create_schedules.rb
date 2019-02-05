class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date :start_date
      t.date :end_date
      t.string :frequency
      t.boolean :active
      t.integer :task_id

      t.timestamps null: false
    end
  end
end
