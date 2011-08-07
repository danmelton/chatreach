class ChangeSettingsToText < ActiveRecord::Migration
  def self.up
    change_column :brand_settings, :setting, :text
  end

  def self.down
    change_column :brand_settings, :setting, :string
  end
end
