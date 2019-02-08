class RemoveResourceIdFromBookResources < ActiveRecord::Migration
  def change
    remove_column :book_resources, :resource_id, :integer
  end
end
