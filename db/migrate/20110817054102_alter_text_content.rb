class AlterTextContent < ActiveRecord::Migration
  def self.up
    remove_column :text_contents, :user_id
    remove_column :text_contents, :published
    add_column :text_contents, :tag_id, :integer
    add_column :text_contents, :category_id, :integer
  end

  def self.down
    remove_column :text_contents, :category_id
    remove_column :text_contents, :tag_id
    add_column :text_contents, :user_id, :integer
    add_column :text_contents, :published, :boolean
  end
end