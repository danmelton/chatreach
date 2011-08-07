class CreateProfileTypes < ActiveRecord::Migration
  def self.up
    create_table :profile_types do |t|
      t.string :name
      t.string :thumbnail
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :profile_types
  end
end
