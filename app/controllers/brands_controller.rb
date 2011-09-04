class BrandsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :brand_admin, :only => [:update, :edit, :add_or_remove_admin]
  before_filter :admin, :only => [:create, :new, :destroy]  
  layout "application"
  
  def show
    session[:brand] = params[:id]
    flash[:success] = "Changed Brand"
    redirect_to :back
  end
  
  def create
    @brand = Brand.new(params[:brand])
    if @brand.save
      if params[:copy_brand]
        copy_brand = Brand.where(:id => params[:copy_brand][:id]).first
        @brand.copy_text_content_from(copy_brand)
      end
      flash[:success] = "Yippee, Brand created!"
      redirect_to edit_brand_path(@brand)      
    else
      flash[:error] = "We had a problem creating that Brand"
      redirect_to new_brand_path(@brand)            
    end
  end
  
  def update
    update! {edit_brand_path(@brand)}
  end
    
  private
    
  def brand_admin
    if !admin? 
      brand = Brand.find(params[:id])
      if !brand.admins.include?(current_user) 
        redirect_to :back
      end
    end
  end
end
