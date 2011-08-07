class HomeController < ApplicationController
  before_filter :setup  
  layout "home"
  
  def index
  end
  
  def about
  end
  
  def contact
  end
  
  def thankyou
  end
  
  def blog
  if params[:id].nil?
    @blogs = Account.find(1).blogs.published
    render "blog"
  else
    @blog = Account.find(1).blogs.published.find(params[:id])
    render "blog_entry"
  end
  end
  
  def rss 
    account = Account.find(1) 
    @blogs = account.blogs.published
    response.headers["Content-Type"] = "application/xml; charset=utf-8"  
    render :action=>"rss", :layout=>false  
  end
  
  def webinars
  end
  
  def webinar
  end
  
  private
  
  def setup
    @user = ::User.new
    @blogs = Account.find(1).blogs.published.limit_to(5)
  end


end
