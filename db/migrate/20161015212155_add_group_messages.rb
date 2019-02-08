class AddGroupMessages < ActiveRecord::Migration
  def change
  	create_table :group_messages do |t|
      t.integer :from
      t.integer :group_id
      t.string :content

      t.timestamps null: false
    end
  end
end
