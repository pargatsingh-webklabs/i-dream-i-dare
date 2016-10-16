class DropTableGroupMessages < ActiveRecord::Migration
  	def up
  	drop_table :group_messages
  end
  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
