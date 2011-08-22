class TagsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :brand_admin, :except => [:index, :show] 
  
  layout "application"
  
  def create
    tag = Tag.where(:name => params[:tag][:name])
    if tag.blank?
      create! {tags_path}
    else
      flash[:notice] = "That tag already exists"
      redirect_to new_tag_path
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
