class CreateBioQuestions < ActiveRecord::Migration
  def change
    create_table :bio_questions do |t|
      t.text :question_text
      t.integer :question_order_by
      t.boolean :active

      t.timestamps null: false
    end
  end
end
