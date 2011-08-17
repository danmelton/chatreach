class CreateTagTextContents < ActiveRecord::Migration
  def self.up
    create_table :tag_text_contents do |t|
      t.integer :tag_id
      t.integer :text_content_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_text_contents
  end
end
