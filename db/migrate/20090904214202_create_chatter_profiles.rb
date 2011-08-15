class CreateChatterProfiles < ActiveRecord::Migration
  def self.up
    create_table :chatter_profiles do |t|
      t.date :birthday
      t.integer :age
      t.string :gender
      t.string :phone
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :first_name
      t.string :last_name
      t.integer :chatter_id
      t.timestamps
    end
  end

  def self.down
    drop_table :chatter_profiles
  end
end
