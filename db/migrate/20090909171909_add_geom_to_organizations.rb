class AddGeomToOrganizations < ActiveRecord::Migration
  def self.up
    add_column :organizations, :geom, :point
  end

  def self.down
    remove_column :organizations, :geom
  end
end
