class AddFlagToTextHistories < ActiveRecord::Migration
  def self.up
    add_column :text_histories, :flag, :boolean, :default => false
  end

  def self.down
    remove_column :text_histories, :flag
  end
end
