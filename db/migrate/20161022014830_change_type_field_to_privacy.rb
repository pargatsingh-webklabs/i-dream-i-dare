class ChangeTypeFieldToPrivacy < ActiveRecord::Migration
  def change
  	remove_column :groups, :type, :string
  	add_column :groups, :privacy, :string
  end
end
