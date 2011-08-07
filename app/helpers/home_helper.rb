module HomeHelper
  
  def signedin(user)
    if current_user.nil?
      render :partial => 'home/login'
    else
      render :partial => 'home/welcome'
    end
  end
  
end
