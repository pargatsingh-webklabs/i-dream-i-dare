class CreateUserSchedules < ActiveRecord::Migration
  def change
    create_table :user_schedules do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
