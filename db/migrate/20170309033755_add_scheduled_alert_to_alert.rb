class AddScheduledAlertToAlert < ActiveRecord::Migration
  def change
    add_column :alerts, :scheduled_alert, :datetime
  end
end
