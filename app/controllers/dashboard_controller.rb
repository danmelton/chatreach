class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "application"
  
  def index
    if session[:brand].nil?
      session[:brand] = Brand.first.id
    end 
  
    if session[:admin] or current_user.admin?
      @users = User.all(:order => :email)
    end 

  end
  

end
