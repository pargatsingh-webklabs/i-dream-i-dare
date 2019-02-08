class AddActiveToMentorships < ActiveRecord::Migration
  def change
    add_column :mentorships, :active, :boolean
  end
end
