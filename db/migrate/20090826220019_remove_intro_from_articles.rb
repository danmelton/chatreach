class RemoveIntroFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :intro
  end

  def self.down
    add_column :articles, :intro, :text
  end
end
