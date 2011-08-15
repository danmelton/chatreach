class DropAccountIdFromTables < ActiveRecord::Migration
  def self.up
    remove_column :categories, :account_id
    remove_column :brand_settings, :account_id    
  end

  def self.down
    add_column :categories, :account_id, :integer
    add_column :brand_settings, :account_id    
  end
end