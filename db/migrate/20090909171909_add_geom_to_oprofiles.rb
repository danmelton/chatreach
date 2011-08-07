class AddGeomToOprofiles < ActiveRecord::Migration
  def self.up
    add_column :oprofiles, :geom, :point
  end

  def self.down
    remove_column :oprofiles, :geom
  end
end
