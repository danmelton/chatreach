class CreateSessionPowerons < ActiveRecord::Migration
  def self.up
    create_table :session_powerons do |t|
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :session_powerons
  end
end
