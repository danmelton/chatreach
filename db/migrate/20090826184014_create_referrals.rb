class CreateReferrals < ActiveRecord::Migration
  def self.up
    create_table :referrals do |t|
      t.integer :user_id
      t.string :code
      t.integer :brand_id
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :referrals
  end
end
