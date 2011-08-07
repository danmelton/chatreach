class CreateSessionVideos < ActiveRecord::Migration
  def self.up
    create_table :session_videos do |t|
      t.integer :account_id
      t.integer :video_id
      t.time :start_time
      t.time :end_time
      t.integer :referral_id
      t.integer :session_poweron_id

      t.timestamps
    end
  end

  def self.down
    drop_table :session_videos
  end
end
