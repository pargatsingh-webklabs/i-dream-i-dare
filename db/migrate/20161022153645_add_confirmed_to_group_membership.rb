class AddConfirmedToGroupMembership < ActiveRecord::Migration
  def change
  	add_column :group_memberships, :confirmed, :boolean
  end
end
