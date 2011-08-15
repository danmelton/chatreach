class CreateBrandSettings < ActiveRecord::Migration
  def self.up
    create_table :brand_settings do |t|
      t.integer :brand_id
      t.string :name
      t.string :setting

      t.timestamps
    end
  end

  def self.down
    drop_table :brand_settings
  end
end
