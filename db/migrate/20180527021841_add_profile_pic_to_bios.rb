class AddProfilePicToBios < ActiveRecord::Migration
  def change
    add_column :bios, :profile_image, :string
  end
end
