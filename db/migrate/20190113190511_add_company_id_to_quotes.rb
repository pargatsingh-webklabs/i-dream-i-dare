class AddCompanyIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :company_id, :integer
  end
end
