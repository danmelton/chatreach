class ChangeZipcodeChatterProfiles < ActiveRecord::Migration
  def self.up
    change_column :chatter_profiles, :zipcode, :string
  end

  def self.down
    change_column :chatter_profiles, :zipcode, :string
  end
end
