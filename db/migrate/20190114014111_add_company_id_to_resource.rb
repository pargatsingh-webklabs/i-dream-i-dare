class AddCompanyIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :company_id, :integer
  end
end
