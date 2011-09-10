require 'builder'
class TextMessagesController < ApplicationController
  def index      
    # check for text caster
    if params[:phoneNumber]
      msg = TextMessage.new(params[:phoneNumber], params[:message])
      @response = msg.get_response
      render :xml => Builder::XmlMarkup.new.root { |x| x.result { |y| y.cdata! @response}}
    elsif params[:SmsSid]
      msg = TextMessage.new(params[:From], params[:Body])
      @response = msg.get_response
      xml = Builder::XmlMarkup.new
      xml.instruct!
      render :xml => xml.Response { |x| x.Sms @response}      
    end
  end
  
  def simulator
  end
  
end
