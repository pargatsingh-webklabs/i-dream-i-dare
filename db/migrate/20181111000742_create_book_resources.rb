class CreateBookResources < ActiveRecord::Migration
  def change
    create_table :book_resources do |t|
      t.integer :resource_id
      t.boolean :active

      t.timestamps null: false
    end
  end
end
