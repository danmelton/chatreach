class CreateFeedSources < ActiveRecord::Migration
  def self.up
    create_table :feed_sources do |t|
      t.string :name
      t.string :url
      t.string :feed_type
      t.integer :brand_id
      t.string :source
      t.timestamps
    end
  end

  def self.down
    drop_table :feed_sources
  end
end
