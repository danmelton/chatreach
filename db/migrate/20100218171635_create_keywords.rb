class CreateKeywords < ActiveRecord::Migration
  def self.up
    create_table :keywords do |t|
      t.integer :brand_id
      t.integer :weight
      t.string :content

      t.timestamps
    end
  end

  def self.down
    drop_table :keywords
  end
end
