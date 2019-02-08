class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :logo_path
      t.string :name
      t.text :description
      t.string :logo_filename
      t.boolean :active

      t.timestamps null: false
    end
  end
end
