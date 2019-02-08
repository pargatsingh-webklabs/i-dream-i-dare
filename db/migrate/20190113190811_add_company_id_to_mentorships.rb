class AddCompanyIdToMentorships < ActiveRecord::Migration
  def change
    add_column :mentorships, :company_id, :integer
  end
end
