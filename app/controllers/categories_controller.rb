class CategoriesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :brand_admin, :except => [:index, :show] 
  
  layout "application"
  
  def index
    @search = Category.search(params[:search])
    @categories = @search.paginate(
      :per_page => 50, :page => params[:page])
    
  end
  
  def create
    category = Category.where(:name => params[:category][:name])
    if category.blank?
      create! {categories_path}
    else
      flash[:notice] = "That category already exists"
      redirect_to new_category_path
    end
  end

  def update
    update! {categories_path}
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
