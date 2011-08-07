class TextMessagesController < ApplicationController
  def index  
    msg = TextMessage.new(params[:sessionId],params[:phoneNumber],params[:carrierID],params[:message])
    @response = msg.response
  end
  
  def simulator
    
  end

end
