class AddListFeatureToBrands < ActiveRecord::Migration
  def self.up
    Brand.all.each do |brand|
      if brand.list_tags.nil?
        brand.brand_settings.create(:name => "list_tags")
      end
    end
  end

  def self.down
  end
end
