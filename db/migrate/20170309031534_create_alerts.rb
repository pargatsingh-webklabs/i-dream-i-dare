class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :alert_title
      t.text :alert_body
      t.string :alert_type
      t.integer :alert_to

      t.timestamps null: false
    end
  end
end
