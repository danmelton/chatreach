class CreateFaqs < ActiveRecord::Migration
  def self.up
    create_table :faqs do |t|
      t.integer :brand_id
      t.integer :user_id
      t.text :content
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :faqs
  end
end
