class CreateMentorships < ActiveRecord::Migration
  def change
    create_table :mentorships do |t|
      t.integer :client
      t.integer :coach

      t.timestamps null: false
    end
  end
end
