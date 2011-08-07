class CreatePoweronKeywords < ActiveRecord::Migration
  def self.up
    create_table :poweron_keywords do |t|
      t.integer :poweron_chatter_id
      t.integer :keyword_id
      t.timestamps
    end
  end

  def self.down
    drop_table :poweron_keywords
  end
end
