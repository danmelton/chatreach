class CreateBrandOrganizations < ActiveRecord::Migration
  def self.up
    create_table :brand_organizations do |t|
      t.integer :brand_id
      t.integer :organization_id

      t.timestamps
    end
  end

  def self.down
    drop_table :brand_organizations
  end
end
