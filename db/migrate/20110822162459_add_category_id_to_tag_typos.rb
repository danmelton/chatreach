class AddCategoryIdToTagTypos < ActiveRecord::Migration
  def self.up
    add_column :tag_typos, :category_id, :integer
  end

  def self.down
    remove_column :tag_typos, :category_id
  end
end