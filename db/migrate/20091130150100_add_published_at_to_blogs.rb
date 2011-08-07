class AddPublishedAtToBlogs < ActiveRecord::Migration
  def self.up
    add_column :blogs, :published_at, :datetime
  end

  def self.down
    remove_column :blogs, :published_at
  end
end
