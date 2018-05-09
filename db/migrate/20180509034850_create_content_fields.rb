class CreateContentFields < ActiveRecord::Migration
  def change
    create_table :content_fields do |t|
      t.string :name
      t.string :value

      t.timestamps null: false
    end
  end
end
