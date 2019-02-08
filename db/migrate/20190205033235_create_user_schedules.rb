class CreateUserSchedules < ActiveRecord::Migration
  def change
    create_table :user_schedules do |t|
      t.int :user_id
      t.int :schedule_id
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
