class AddMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :organizations, :id         
    add_index :text_histories, :id        
    add_index :text_sessions, :id                
    add_index :text_contents, :id            
  end

  def self.down
    drop_index :organizations, :id        
    drop_index :text_histories, :id        
    drop_index :text_sessions, :id                
    drop_index :text_contents, :id    
  end
end
