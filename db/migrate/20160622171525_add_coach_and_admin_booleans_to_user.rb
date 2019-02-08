class AddCoachAndAdminBooleansToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_a_coach, :boolean
    add_column :users, :is_an_admin, :boolean
  end
end