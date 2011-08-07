class AlterPhoneOnTextSession < ActiveRecord::Migration
  def self.up
    change_column :text_sessions, :phone, :string
  end

  def self.down
    change_column :text_sessions, :phone, :integer
  end
end
