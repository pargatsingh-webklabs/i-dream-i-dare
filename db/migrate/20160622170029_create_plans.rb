class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :client
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
