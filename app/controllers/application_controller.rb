class ApplicationController < ActionController::Base

  protect_from_forgery
  
  def random_alpha(size=5)
    s = ""
    size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    s
  end

    
  def admin?
    current_user.admin?
  end

  def admin
    if !admin?
      flash[:failure] = "You need to be an admin!"
      redirect_to :back
    end  
  end
  
end
