class AddCategoryToTextHistories < ActiveRecord::Migration
  def self.up
    add_column :text_histories, :category_id, :integer
    add_column :text_histories, :text_content_id, :integer
  end

  def self.down
    remove_column :text_histories, :text_content_id
    remove_column :text_histories, :category_id
  end
end