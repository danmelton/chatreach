class SettingsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @settings = BrandSetting.all_settings(current_user.account.id, session[:brand])
    @brand = @settings.first.brand.name
  end
  
  def update
    @settings = BrandSetting.all_settings(current_user.account.id, session[:brand])
    @settings.each do |s|
      brand = "brand_setting_#{s.id}"
      s.update_attributes(:setting => params[brand.to_sym])
    end
    flash[:notice] = "Settings updated"
    redirect_to("/settings/")
  end

end
