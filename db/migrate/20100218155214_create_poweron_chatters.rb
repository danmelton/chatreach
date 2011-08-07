class CreatePoweronChatters < ActiveRecord::Migration
  def self.up
    create_table :poweron_chatters do |t|
      t.string :screen_name
      t.integer :profile_id
      t.integer :account_id      
      t.integer :age
      t.integer :gender
      t.integer :hiv
      t.integer :race
      t.integer :sexual_orientation
      t.integer :drug_use
      t.integer :alcohol_use
      t.integer :smoking
      t.integer :out_level
      t.integer :risk_level
      t.timestamps
    end
  end

  def self.down
    drop_table :poweron_chatters
  end
end
