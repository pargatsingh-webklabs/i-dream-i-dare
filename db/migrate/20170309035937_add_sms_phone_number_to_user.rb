class AddSmsPhoneNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :sms_phone_number, :integer
  end
end
