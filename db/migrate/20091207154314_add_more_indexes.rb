class AddMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :session_powerons, :id    
    add_index :session_powerons, :referral_id        
    add_index :accounts, :id        
    add_index :oprofiles, :id        
    add_index :uprofiles, :id        
    add_index :session_videos, :id        
    add_index :text_histories, :id        
    add_index :text_sessions, :id                
    add_index :text_contents, :id            
  end

  def self.down
    drop_index :session_powerons, :id    
    drop_index :session_powerons, :referral_id        
    drop_index :accounts, :id        
    drop_index :oprofiles, :id        
    drop_index :uprofiles, :id        
    drop_index :session_videos, :id        
    drop_index :text_histories, :id        
    drop_index :text_sessions, :id                
    drop_index :text_contents, :id    
  end
end
