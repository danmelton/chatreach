class CreateTextContents < ActiveRecord::Migration
  def self.up
    create_table :text_contents do |t|
      t.integer :brand_id
      t.integer :tag_id
      t.integer :category_id
      t.string :response
      t.timestamps
    end
  end

  def self.down
    drop_table :text_contents
  end
end
