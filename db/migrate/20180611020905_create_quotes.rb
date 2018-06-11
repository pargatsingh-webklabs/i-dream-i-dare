class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text :body
      t.string :author
      t.string :url_for_image

      t.timestamps null: false
    end
  end
end
