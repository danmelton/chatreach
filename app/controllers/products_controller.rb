class ProductsController < ApplicationController
  layout "home"

  before_filter :setup

  def index
    @user = ::User.new(params[:user])
  end
  
  def sext
    case params[:name]
    when "about"
      render "products/sext/about"
    when "tour"
      render "products/sext/tour"    
    when "faqs"
      @faqs = Faq.with_brand(Brand.find_by_name('sext').id)      
      render "products/sext/faqs"        
    when "pricing"
      render "products/sext/pricing"        
    when "research"
      render "products/sext/research"        
    else
      render "products/sext/index"        
    end
  end
  
  private
  
  def setup
    @user = ::User.new(params[:user])
    @blogs = Account.find(1).blogs.published.limit_to(5)
  end
    
  
end
