class CategoriesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :brand_admin, :except => [:index, :show] 
  
  layout "application"
  
  def create
    category = Category.where(:name => params[:category][:name])
    if category.blank?
      create!
    else
      flash[:notice] = "That category already exists"
      redirect_to category_path(category.first)
    end
  end
  
  private
    
  def brand_admin
    if !admin? 
      brand = Brand.find(session[:brand])
      if !brand.admins.include?(current_user) 
        redirect_to :back
      end
    end
  end
  

end
