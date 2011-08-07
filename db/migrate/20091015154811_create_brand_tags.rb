class CreateBrandTags < ActiveRecord::Migration
  def self.up
    create_table :brand_tags do |t|
      t.integer :tag_id
      t.integer :brand_id

      t.timestamps
    end
  end

  def self.down
    drop_table :brand_tags
  end
end
