class AddTextTypeToTextHistories < ActiveRecord::Migration
  def self.up
    add_column :text_histories, :text_type, :string
  end

  def self.down
    remove_column :text_histories, :text_type
  end
end
