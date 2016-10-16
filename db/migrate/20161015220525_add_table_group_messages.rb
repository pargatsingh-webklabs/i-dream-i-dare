class AddTableGroupMessages < ActiveRecord::Migration
    def change
  	create_table :group_messages do |t|
      t.integer :from
      t.integer :group_id
      t.text :content

      t.timestamps null: false
    end
  end
end
