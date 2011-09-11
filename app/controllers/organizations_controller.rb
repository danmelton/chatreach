class OrganizationsController < InheritedResources::Base
  actions :create, :destroy, :edit, :new, :update, :index
  before_filter :authenticate_user!
  before_filter :brand_admin, :only => [:create, :new, :destroy, :update, :edit]    
  layout "application"
  
  def index
    @search = Organization.search(params[:search])
    @organizations = @search.paginate(
      :per_page => 15, :page => params[:page])
  end
  
  def update
    update! {edit_organization_path(@organization)}
  end
    
  private
    
  def brand_admin
    if !admin? 
      brand = Brand.find(session[:brand])
      if !brand.admins.include?(current_user)
        @brand_admin = true 
        redirect_to :back
      end
    end
  end
end
