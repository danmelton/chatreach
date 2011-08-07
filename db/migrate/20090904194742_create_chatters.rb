class CreateChatters < ActiveRecord::Migration
  def self.up
    create_table :chatters do |t|
      t.integer :demographic_id
      t.integer :profile_id
      t.integer :social_id
      t.boolean :initiated

      t.timestamps
    end
  end

  def self.down
    drop_table :chatters
  end
end
