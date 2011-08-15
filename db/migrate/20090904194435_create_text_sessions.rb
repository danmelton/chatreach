class CreateTextSessions < ActiveRecord::Migration
  def self.up
    create_table :text_sessions do |t|
      t.integer :brand_id
      t.integer :phone
      t.integer :chatter_id
      t.timestamps
    end
  end

  def self.down
    drop_table :text_sessions
  end
end
