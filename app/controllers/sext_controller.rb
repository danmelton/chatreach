class SextController < ApplicationController
  def index
    setting = BrandSetting.with_domain(request.host).first
    @about = BrandSetting.with_account(setting.account.id).with_brand(setting.brand.id).with_name('about').first
  end
    
  def contact
    setting = BrandSetting.with_domain(request.host).first
    @contact = BrandSetting.with_account(setting.account.id).with_brand(setting.brand.id).with_name('contact').first
  end
  
  def parents
    setting = BrandSetting.with_domain(request.host).first
    @parent = BrandSetting.with_account(setting.account.id).with_brand(setting.brand.id).with_name('for parents').first        
  end

end
