class ChangeTitleToNameInArticles < ActiveRecord::Migration
  def self.up
    rename_column :articles, :title, :name
  end

  def self.down
    rename_column :articles, :name, :title
  end
end
