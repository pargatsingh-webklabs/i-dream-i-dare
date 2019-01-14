class AddCompanyIdToGroupMessage < ActiveRecord::Migration
  def change
    add_column :group_messages, :company_id, :integer
  end
end
