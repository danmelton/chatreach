require 'builder'
class TextMessagesController < ApplicationController
  def index  
    msg = TextMessage.new(params[:phoneNumber], params[:message])
    @response = msg.get_response
    
    # check for text caster
    if msg.brand.provider.setting == 'text caster'
      render :xml => Builder::XmlMarkup.new.root { |x| x.result { |y| y.cdata! @response}}
    else
    end
  end
  
  def simulator
  end
  
end
