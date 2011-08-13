class BrandsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :brand_admin, :only => [:update, :edit]
  before_filter :admin, :only => [:create, :new, :destroy]  
  layout "application"
  
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
