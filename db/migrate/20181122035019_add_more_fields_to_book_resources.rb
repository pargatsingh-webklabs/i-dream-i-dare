class AddMoreFieldsToBookResources < ActiveRecord::Migration
  def change
    add_column :book_resources, :file_name, :string
  end
end
