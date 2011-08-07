class AddAccountIdToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :account_id, :integer, :default => "1"
  end

  def self.down
    remove_column :table_name, :column_name
    remove_column :categories, :account_id
  end
end
