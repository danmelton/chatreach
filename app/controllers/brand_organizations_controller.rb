class BrandOrganizationsController < InheritedResources::Base
  actions :create, :destroy
  before_filter :authenticate_user!
  before_filter :brand_admin
  
  def create
    create! {:back}
  end
  
  def destroy
    destroy! {:back}
  end
  
  private
    
  def brand_admin
    if !admin? 
      if current_user.brands.blank?
        redirect_to :back
      end
    end
  end
  
end