class CreateTagTypos < ActiveRecord::Migration
  def self.up
    create_table :tag_typos do |t|
      t.integer :tag_id
      t.string :typo

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_typos
  end
end
