class CreateConversations < ActiveRecord::Migration
  def self.up
    create_table :conversations do |t|
      t.integer :account_id
      t.integer :brand_id
      t.integer :user_id
      t.integer :account_id
      t.text :transcript

      t.timestamps
    end
  end

  def self.down
    drop_table :conversations
  end
end
