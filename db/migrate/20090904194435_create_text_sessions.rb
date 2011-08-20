class CreateTextSessions < ActiveRecord::Migration
  def self.up
    create_table :text_sessions do |t|
      t.integer :brand_id
      t.integer :chatter_id
      t.string :session
      t.timestamps
    end
  end

  def self.down
    drop_table :text_sessions
  end
end
