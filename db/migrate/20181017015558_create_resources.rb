class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.text :resource_string
      t.integer :resource_type_id
      t.string :tag_1
      t.string :tag_2
      t.string :tag_3

      t.timestamps null: false
    end
  end
end
