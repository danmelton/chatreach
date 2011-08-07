class AddAuthorToFeedSources < ActiveRecord::Migration
  def self.up
    add_column :feed_sources, :author, :string
    rename_column :feed_sources, :feed_type, :source_url
  end

  def self.down
    rename_column :feed_sources, :source_url, :feed_type
    remove_column :feed_sources, :author
  end
end
