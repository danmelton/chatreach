class AddCategoryToTextHistories < ActiveRecord::Migration
  def self.up
    add_column :text_histories, :category_id, :integer
  end

  def self.down
    remove_column :text_histories, :category_id
  end
end
