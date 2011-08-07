class CreateBrandAdmins < ActiveRecord::Migration
  def self.up
    create_table :brand_admins do |t|
      t.integer :user_id
      t.integer :brand_id

      t.timestamps
    end
  end

  def self.down
    drop_table :brand_admins
  end
end
