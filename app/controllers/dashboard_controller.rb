class DashboardController < ApplicationController
  before_filter :authenticate_user!
  layout "application"
  
  def index
    if session[:brand].nil?
      session[:brand] = Brand.first.id
    end 
    brand = Brand.find(session[:brand])      
    if params[:time]
    time1 = params[:time][:"time1(1i)"].nil? ? 30.days.ago : Date.civil(params[:time][:"time1(1i)"].to_i,params[:time][:"time1(2i)"].to_i,params[:time][:"time1(3i)"].to_i)
    time2 = params[:time][:"time2(1i)"].nil? ? Time.now : Date.civil(params[:time][:"time2(1i)"].to_i,params[:time][:"time2(2i)"].to_i,params[:time][:"time2(3i)"].to_i)
    @dashboard = Dashboard.new(brand,time1, time2)      
    else
    @dashboard = Dashboard.new(brand)
    end
  end
  

end
