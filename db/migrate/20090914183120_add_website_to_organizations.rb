class AddWebsiteToOrganizations < ActiveRecord::Migration
  def self.up
    add_column :organizations, :website, :string
    add_column :organizations, :email, :string    
  end

  def self.down
    remove_column :organizations, :website
    remove_column :organizations, :email    
  end
end
 