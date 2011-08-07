class CreateAccountBrands < ActiveRecord::Migration
  def self.up
    create_table :account_brands do |t|
      t.integer :account_id
      t.integer :brand_id

      t.timestamps
    end
  end

  def self.down
    drop_table :account_brands
  end
end
