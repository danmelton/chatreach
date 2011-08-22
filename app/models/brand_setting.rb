# Brand Settings:
# Welcome - Intro message sent on first text or keyword
# Clinic Not Found - Message when a clinic or resource can't be found
# Info Not Found - Message when a response can't be found


class BrandSetting < ActiveRecord::Base
  belongs_to :brand
  validates_presence_of :name, :brand
  validates_uniqueness_of :name, :scope => :brand_id

end
