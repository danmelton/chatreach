class CreateUprofiles < ActiveRecord::Migration
  def self.up
    create_table :uprofiles do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :country
      t.integer :phone
      t.integer :mobile
      t.integer :pager
      t.string :about
      t.string :first_name
      t.string :last_name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :uprofiles
  end
end
