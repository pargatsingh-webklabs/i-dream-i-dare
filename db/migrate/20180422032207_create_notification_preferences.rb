class CreateNotificationPreferences < ActiveRecord::Migration
  def change
    create_table :notification_preferences do |t|
      t.string :notification_reason
      t.string :notification_type
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
