class CreateOprofiles < ActiveRecord::Migration
  def self.up
    create_table :oprofiles do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
      t.integer :phone
      t.integer :mobile
      t.integer :pager
      t.string :about
      t.string :sms_about
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :oprofiles
  end
end
