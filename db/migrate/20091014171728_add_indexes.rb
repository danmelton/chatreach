class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :videos, :id
    add_index :videos, :name
    add_index :articles, :id
    add_index :articles, :title
    add_index :feed_entries, :id
  end

  def self.down  
  end
end
