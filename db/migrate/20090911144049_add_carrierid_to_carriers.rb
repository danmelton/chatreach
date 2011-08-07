class AddCarrieridToCarriers < ActiveRecord::Migration
  def self.up
    add_column :carriers, :carrierid, :string
  end

  def self.down
    remove_column :carriers, :carrierid
  end
end
