class RemoveAccountId < ActiveRecord::Migration
  def self.up
    remove_column :articles, :account_id
  end

  def self.down
    add_column :articles, :account_id, :integer
  end
end
