class AddFieldsToBookResources < ActiveRecord::Migration
  def change
    add_column :book_resources, :path, :string
  end
end
