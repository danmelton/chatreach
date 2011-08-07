class AddWebsiteToOprofiles < ActiveRecord::Migration
  def self.up
    add_column :oprofiles, :website, :string
    add_column :oprofiles, :email, :string    
  end

  def self.down
    remove_column :oprofiles, :website
    remove_column :oprofiles, :email    
  end
end
