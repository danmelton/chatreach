class ChattersController < InheritedResources::Base
  actions :index, :show
  before_filter :authenticate_user!

  def index
    @chatters = Chatter.paginate(
      :per_page => 100, :page => params[:page])
  end

end