class CreateAccountTexts < ActiveRecord::Migration
  def self.up
    create_table :account_texts do |t|
      t.integer :account_id
      t.integer :text_content_id

      t.timestamps
    end
  end

  def self.down
    drop_table :account_texts
  end
end
