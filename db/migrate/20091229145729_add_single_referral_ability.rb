class AddSingleReferralAbility < ActiveRecord::Migration
  def self.up
    add_column :referrals, :rcontent_id, :integer
    add_column :referrals, :rcontent_type, :string
  end

  def self.down
    remove_column :referrals, :rcontent_type
    remove_column :referrals, :rcontent_id

  end
end
