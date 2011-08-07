class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all
  
  before_filter :prepare_for_mobile

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
  
  def check_login_brand
    if session[:brand].nil? and current_user
    session[:brand] = current_user.account.brands.first.id unless current_user.account.brands.blank?      
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
  
  def is_mobile?
    if request.user_agent =~ /Mobile|webOS/
      true
    else
      false
    end
  end
  helper_method :is_mobile?
  
  def brand_admin?
    if session[:brand]
      Brand.find(session[:brand]).admins.include?(current_user)
    end
  end
  helper_method :brand_admin?
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?
  
  def prepare_for_mobile
      session[:mobile_param] = params[:mobile] if params[:mobile]
      request.format = :mobile if mobile_device?
  end

end
