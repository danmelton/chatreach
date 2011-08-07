class CreateArticleBrands < ActiveRecord::Migration
  def self.up
    create_table :article_brands do |t|
      t.integer :brand_id
      t.integer :article_id

      t.timestamps
    end
  end

  def self.down
    drop_table :article_brands
  end
end
