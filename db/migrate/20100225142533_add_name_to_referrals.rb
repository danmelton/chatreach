class AddNameToReferrals < ActiveRecord::Migration
  def self.up
    add_column :referrals, :name, :string
  end

  def self.down
    remove_column :referrals, :name
  end
end
