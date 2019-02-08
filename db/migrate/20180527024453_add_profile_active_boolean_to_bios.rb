class AddProfileActiveBooleanToBios < ActiveRecord::Migration
  def change
    add_column :bios, :profile_active, :bool
  end
end
