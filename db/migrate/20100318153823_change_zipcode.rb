class ChangeZipcode < ActiveRecord::Migration
  def self.up
    change_column :oprofiles, :zip, :string
    change_column :uprofiles, :zip, :string
  end

  def self.down
    change_column :uprofiles, :zip, :string
    change_column :oprofiles, :zip, :string
  end
end
