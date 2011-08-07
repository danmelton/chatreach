class AlterPhoneOnProfiles < ActiveRecord::Migration
  def self.up
    change_column :oprofiles, :phone, :string
    change_column :oprofiles, :mobile, :string
    change_column :oprofiles, :pager, :string    
    change_column :uprofiles, :phone, :string
    change_column :uprofiles, :mobile, :string
    change_column :uprofiles, :pager, :string    
  end

  def self.down      
  end
end
