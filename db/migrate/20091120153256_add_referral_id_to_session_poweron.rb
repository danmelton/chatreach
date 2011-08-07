class AddReferralIdToSessionPoweron < ActiveRecord::Migration
  def self.up
    add_column :session_powerons, :referral_id, :integer
  end

  def self.down
    remove_column :session_powerons, :referral_id
  end
end
