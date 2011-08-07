class AddCustodialIdToOprofiles < ActiveRecord::Migration
  def self.up
    add_column :oprofiles, :custodial_id, :integer
  end

  def self.down
    remove_column :oprofiles, :custodial_id
  end
end
