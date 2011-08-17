class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.integer :phone
      t.string :sms_about
      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
