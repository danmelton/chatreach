module UsersHelper
  
  def delete_user(user)
    if current_user.admin == true and user.inactive?
      link_to 'Activate', user, :confirm => 'Are you sure?', :method => :delete 
    else
      link_to 'Make Inactive', user, :confirm => 'Are you sure?', :method => :delete 
    end
  end
  
end
