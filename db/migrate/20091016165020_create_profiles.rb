class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :account_id
      t.integer :brand_id
      t.string :username
      t.string :password
      t.integer :profile_type_id
      t.string :profile_url
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
