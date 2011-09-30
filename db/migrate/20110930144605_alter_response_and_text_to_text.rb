class AlterResponseAndTextToText < ActiveRecord::Migration
  def self.up
    change_column :text_histories, :text, :text
    change_column :text_histories, :response, :text
  end

  def self.down
    change_column :text_histories, :text, :string
    change_column :text_histories, :response, :string    
  end
end
