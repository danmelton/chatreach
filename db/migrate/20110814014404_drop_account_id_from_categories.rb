class DropAccountIdFromCategories < ActiveRecord::Migration
  def self.up
    remove_column :categories, :account_id
  end

  def self.down
    add_column :categories, :account_id, :integer
  end
end