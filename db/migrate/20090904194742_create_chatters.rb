class CreateChatters < ActiveRecord::Migration
  def self.up
    create_table :chatters do |t|
      t.integer :age
      t.string :gender
      t.string :phone
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country    
      t.timestamps
    end
  end

  def self.down
    drop_table :chatters
  end
end
