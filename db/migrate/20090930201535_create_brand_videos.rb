class CreateBrandVideos < ActiveRecord::Migration
  def self.up
    create_table :brand_videos do |t|
      t.integer :brand_id
      t.integer :video_id

      t.timestamps
    end
  end

  def self.down
    drop_table :brand_videos
  end
end
