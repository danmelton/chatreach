class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.integer :account_id
      t.integer :brand_id
      t.string :cents

      t.timestamps
    end
  end

  def self.down
    drop_table :credits
  end
end
