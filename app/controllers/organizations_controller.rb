class OrganizationsController < InheritedResources::Base
  actions :create, :destroy, :edit, :new, :update, :index
  before_filter :authenticate_user!
  before_filter :brand_admin, :only => [:create, :new, :destroy, :update, :edit]    
  layout "application"
  
  def index
    if session[:brand]
      @brand = Brand.find(session[:brand])
      @search = @brand.organizations.search(params[:search])
    else  
      @search = Organization.search(params[:search])
    end
    @organizations = @search.paginate(
      :per_page => 15, :page => params[:page])
  end
  
  def create
    @organization = Organization.new(params[:organization])
    if session[:brand]
      @brand = Brand.find(session[:brand])
    else
      @brand = Brand.first
    end
      
    @organization.brands << @brand
    
    if @organization.save
        flash[:success] = "Yippee, Brand created!"
        redirect_to edit_organization_path(@organization)
      else
        flash[:error] = "We had a problem creating that Brand"
        redirect_to edit_organization_path(@organization)
    end
    
  end

  def edit
    edit!
  end
  
  def update
    update! {edit_organization_path(@organization)}
  end
    
  private
    
  def brand_admin
    if admin?
    elsif !current_user.brand_admins.blank?
    else
      redirect_to :back
    end
  end
end
