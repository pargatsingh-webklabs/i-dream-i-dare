class CreateAdminMessages < ActiveRecord::Migration
  def change
    create_table :admin_messages do |t|
      t.string :from_name
      t.string :from_email
      t.text :content

      t.timestamps null: false
    end
  end
end
