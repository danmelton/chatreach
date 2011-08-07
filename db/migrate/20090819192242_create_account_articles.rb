class CreateAccountArticles < ActiveRecord::Migration
  def self.up
    create_table :account_articles do |t|
      t.integer :account_id
      t.integer :article_id
      t.timestamps
    end
  end

  def self.down
    drop_table :account_articles
  end
end
