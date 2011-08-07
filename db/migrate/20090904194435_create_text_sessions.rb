class CreateTextSessions < ActiveRecord::Migration
  def self.up
    create_table :text_sessions do |t|
      t.integer :account_id
      t.integer :brand_id
      t.integer :phone
      t.integer :carrier_id
      t.integer :chatter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :text_sessions
  end
end
