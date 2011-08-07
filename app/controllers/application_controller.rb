class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery
  
  def random_alpha(size=5)
    s = ""
    size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    s
  end
  
  def tag_list_name
    if !session[:brand].blank?
      @tag_list_name = Brand.find(session[:brand]).name.downcase.to_s + "_list"
      @brand_tag_list = Brand.find(session[:brand]).tags
    end
  end
    
  def admin?
    current_user.admin?
  end

  def admin
    deny_admin_access("You do not have the necessary access for that.") unless admin?
  end
  
  def brand_admin
    deny_admin_access("You do not have the necessary access for that.") unless brand_admin?
  end

  private

  def deny_admin_access(flash_message = nil)
    flash[:failure] = flash_message if flash_message
    redirect_to('/dashboard')
  end
    
  def brand_admin?
    if session[:brand]
      Brand.find(session[:brand]).admins.include?(current_user)
    end
  end
  helper_method :brand_admin?
  
end
