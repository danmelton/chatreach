class ChangePhoneToString < ActiveRecord::Migration
  def self.up
    change_column :organizations, :phone, :string
  end

  def self.down
  end
end
