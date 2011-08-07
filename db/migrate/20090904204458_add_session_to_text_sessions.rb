class AddSessionToTextSessions < ActiveRecord::Migration
  def self.up
    add_column :text_sessions, :session, :string
  end

  def self.down
    remove_column :text_sessions, :session
  end
end
