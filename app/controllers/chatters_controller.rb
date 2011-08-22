class ChattersController < InheritedResources::Base
  actions :index, :show
  before_filter :authenticate_user!

  def index
    @brand = Brand.where(:id => session[:brand]).first
    @chatters = Chatter.joins(:text_sessions).where("text_sessions.brand_id = #{session[:brand]}").paginate(
      :per_page => 100, :page => params[:page])
  end

end