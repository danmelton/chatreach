class TextContentsController < InheritedResources::Base
  actions :create, :destroy, :edit, :new, :update, :index
  before_filter :authenticate_user!
  before_filter :brand_admin, :only => [:create, :new, :destroy, :update, :edit]    
  layout "application"
  
  def index
    @brand = Brand.find(session[:brand])    
    @search = TextContent.search(params[:search])
    @text_contents = @search.where(:brand_id => session[:brand]).paginate(
      :per_page => 50, :page => params[:page])    
  end
  
  def update
    @text_content = TextContent.where(:id => params[:id]).first
    if @text_content.update_attributes(params[:text_content]) 
      flash[:success] = "Text content was updated!"
      redirect_to edit_text_content_path(@text_content)
    else
      flash[:error] = "We couldnt save it the brand, category and tag combination!"
      redirect_to edit_text_content_path(@text_content)
    end
    
  end
  
  def create
    @text_content = TextContent.new(params[:text_content]) 
    if @text_content.save
      flash[:success] = "Text content was added!"      
      redirect_to edit_text_content_path(@text_content)
    else
      flash[:error] = "We couldnt save it the brand, category and tag combination!"      
      redirect_to new_text_content_path(@text_content)
    end
  end
      
  private
    
  def brand_admin
    if !admin? 
      @brand = Brand.find(session[:brand])
      if !@brand.admins.include?(current_user)
        @brand_admin = true 
        redirect_to :back
      end
    end
  end
  

end
