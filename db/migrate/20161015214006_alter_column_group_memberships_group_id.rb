class AlterColumnGroupMembershipsGroupId < ActiveRecord::Migration
  def up
  	drop_table :group_memberships 
  end
  def down
  	raise ActiveRecord::IrreversibleMigration
  end

end
