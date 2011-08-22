class TagTyposController < InheritedResources::Base
  actions :create, :destroy  
  before_filter :authenticate_user!
  before_filter :brand_admin, :except => [:index, :show] 
  
  layout "application"
  
  def create
    @tag = Tag.where(:name => params[:tag_typo][:name])
    @category = Category.where(:name => params[:tag_typo][:name])    
    if @tag.blank? and @category.blank?
      TagTypo.create(params[:tag_typo])
      flash[:success] = "Woot. Typo added"
      redirect_to :back
    else
      flash[:success] = "We couldn't add that typo, as a tag or action already exists with the same name."
      redirect_to :back    
    end  
  end
  
  def destroy
    @tagtypo = TagTypo.where(:id => params[:id])
    if !@tagtypo.blank?
      @tagtypo.first.destroy
      flash[:success] = "See ya typo! It's been deleted."
      redirect_to :back
    else
      flash[:success] = "We couldn't delete it for some darn reason."
      redirect_to :back    
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
