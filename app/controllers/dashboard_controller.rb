class DashboardController < ApplicationController
  before_filter :authenticate
  layout "application"
  
  def index
  if session[:brand].nil?
    session[:brand] = current_user.account.brands.first.id unless current_user.account.brands.blank?      
  end 
  
  if session[:super] or current_user.super?
    @users = User.all(:order => :email)
  end 
    @profile = current_user.uprofile
    brand = session[:brand]
    if brand.nil?
      brand = '0'
    end
    @help_feature = Help.with_brand(brand).feature(1).first
    @help_recent = Help.with_brand(brand).recent(5)
  end
  

end
