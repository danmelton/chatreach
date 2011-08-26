class UsersController < InheritedResources::Base
  actions :create, :destroy, :update, :edit, :index, :new
  before_filter :authenticate_user!
  before_filter :brand_admin, :only => [:create, :new, :destroy]  
  layout "application"
    
  def edit
    determine_user
  end
  
  def update
    update! {users_path} 
  end
  
  private
    
  def brand_admin
    if !admin? 
      @brand = Brand.find(session[:brand])
      if !@brand.admins.include?(current_user) 
        redirect_to :back
      end
    end
  end
  
  def determine_user
    @brand = Brand.find(session[:brand])
    if current_user.admin? or @brand.admins.include?(current_user)
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
  
      
end
