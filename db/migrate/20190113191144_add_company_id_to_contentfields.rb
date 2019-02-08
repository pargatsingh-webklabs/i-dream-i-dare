class AddCompanyIdToContentfields < ActiveRecord::Migration
  def change
    add_column :content_fields, :company_id, :integer
  end
end
