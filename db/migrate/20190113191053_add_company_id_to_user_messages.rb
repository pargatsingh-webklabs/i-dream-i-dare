class AddCompanyIdToUserMessages < ActiveRecord::Migration
  def change
    add_column :messages, :company_id, :integer
  end
end
