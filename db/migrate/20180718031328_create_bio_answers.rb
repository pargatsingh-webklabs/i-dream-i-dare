class CreateBioAnswers < ActiveRecord::Migration
  def change
    create_table :bio_answers do |t|
      t.integer :bio_question_id
      t.text :answer_text
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
