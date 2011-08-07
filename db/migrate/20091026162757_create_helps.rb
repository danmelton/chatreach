class CreateHelps < ActiveRecord::Migration
  def self.up
    create_table :helps do |t|
      t.integer :brand_id
      t.integer :user_id
      t.text :content
      t.string :title
      t.boolean :feature
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :helps
  end
end
