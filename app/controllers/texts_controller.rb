class TextsController < InheritedResources::Base
  actions :index
  before_filter :authenticate_user!

  def index
    @brand = Brand.find(session[:brand])    
    @search = TextHistory.includes(:text_session).where("text_sessions.brand_id = #{@brand.id}").order("text_histories.created_at DESC").search(params[:search])
    @texts = @search.paginate(
      :per_page => 50, :page => params[:page])    
  end

end