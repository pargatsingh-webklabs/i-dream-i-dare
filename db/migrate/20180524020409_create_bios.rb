class CreateBios < ActiveRecord::Migration
  def change
    create_table :bios do |t|
      t.integer :user_id
      t.string :profile_text
      t.string :style_text
      t.string :expertise

      t.timestamps null: false
    end
  end
end
