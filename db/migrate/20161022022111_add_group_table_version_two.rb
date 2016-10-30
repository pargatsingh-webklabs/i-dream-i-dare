class AddGroupTableVersionTwo < ActiveRecord::Migration
  def change
  	create_table :groups do |t|
      t.integer :creator
      t.string :privacy
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
