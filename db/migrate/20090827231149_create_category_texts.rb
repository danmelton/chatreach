class CreateCategoryTexts < ActiveRecord::Migration
  def self.up
    create_table :category_texts do |t|
      t.integer :category_id
      t.integer :text_content_id

      t.timestamps
    end
  end

  def self.down
    drop_table :category_texts
  end
end
