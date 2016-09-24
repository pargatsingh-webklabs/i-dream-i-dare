class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :created_by
      t.string :type

      t.timestamps null: false
    end
  end
end
