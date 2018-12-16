class AddIsSuperAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_super_admin, :boolean
  end
end
