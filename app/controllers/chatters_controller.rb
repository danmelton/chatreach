class ChattersController < InheritedResources::Base
  actions :index, :show
  before_filter :authenticate_user!

  def index
    @brand = Brand.find(session[:brand])    
    @search = Chatter.includes(:text_sessions).where("text_sessions.brand_id = #{@brand.id}").order("chatters.created_at DESC").search(params[:search])
    @chatters = @search.paginate(
      :per_page => 50, :page => params[:page])    
  end

end