class AddImageToProfileType < ActiveRecord::Migration
  def self.up
    add_column :profile_types, :content_type, :string
    add_column :profile_types, :filename, :string
    add_column :profile_types, :size, :integer
    add_column :profile_types, :width, :integer
    add_column :profile_types, :height, :integer
  end

  def self.down
    remove_column :profile_types, :height
    remove_column :profile_types, :width
    remove_column :profile_types, :size
    remove_column :profile_types, :filename
    remove_column :profile_types, :content_type
  end
end
