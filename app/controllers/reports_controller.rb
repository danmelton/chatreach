class ReportsController < ApplicationController
  layout "application"
  before_filter [:authenticate, :dates]
  
  def show
   if @date_start <= @date_end
     @brand = Brand.find(session[:brand])
     @account = current_user.account
     sext_report
   else
     flash[:error] = "End date should be after the start date!"
   end
  end

  def dates
    if params[:report]
      @date_start = Date.civil(params[:report][:"start(1i)"].to_i,params[:report][:"start(2i)"].to_i,params[:report][:"start(3i)"].to_i)
      @date_end = Date.civil(params[:report][:"end(1i)"].to_i,params[:report][:"end(2i)"].to_i,params[:report][:"end(3i)"].to_i)
    else
      @date_start = 30.days.ago
      @date_end = Time.now
    end
  end
  
  private
  
  def sext_report
    @charts = TextReport.new(:start_date => @date_start,:end_date => @date_end, :account => @account, :brand => @brand)
    @total_chatters = @charts.total_chatters.size
    @total_chatters_graph = @charts.total_chatters_graph
    @total_new_chatters = @charts.total_new_chatters.size          
    @total_new_chatters_graph = @charts.total_new_chatters_graph          
    @total_content = @charts.total_content.size
    @total_content_graph = @charts.total_content_graph
  end
    
end