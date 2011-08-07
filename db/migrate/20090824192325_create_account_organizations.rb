class CreateAccountOrganizations < ActiveRecord::Migration
  def self.up
    create_table :account_organizations do |t|
      t.integer :account_id
      t.integer :oprofile_id
      t.integer :brand_id

      t.timestamps
    end
    add_column :oprofiles, :name, :string
  end

  def self.down
    remove_column :oprofiles, :name
    drop_table :account_organizations
  end
end
