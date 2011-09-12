class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "application"
  
  def index
    if session[:brand].nil?
      session[:brand] = Brand.first.id
    end 
    @dashboard = Dashboard.new

  end
  

end
