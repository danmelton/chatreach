class ChattersController < InheritedResources::Base
  actions :index, :show
  before_filter :authenticate_user!
  
end