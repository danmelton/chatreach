class CreateTextHistories < ActiveRecord::Migration
  def self.up
    create_table :text_histories do |t|
      t.integer :text_session_id
      t.integer :tag_id
      t.string :text
      t.string :response

      t.timestamps
    end
  end

  def self.down
    drop_table :text_histories
  end
end
