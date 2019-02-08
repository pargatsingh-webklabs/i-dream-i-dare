class IncreaseSmsNumberCharacterLimit < ActiveRecord::Migration
  def change
    change_column :users, :sms_phone_number, :integer, :limit => 8
  end
end
