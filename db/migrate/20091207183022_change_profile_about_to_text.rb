class ChangeProfileAboutToText < ActiveRecord::Migration
  def self.up
    change_column :oprofiles, :about, :text
    change_column :uprofiles, :about, :text
  end

  def self.down
    change_column :uprofiles, :about, :string
    change_column :oprofiles, :about, :string
  end
end
