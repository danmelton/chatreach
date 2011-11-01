require 'builder'
class TextMessagesController < ApplicationController
  def index      
    # check for text caster
    if params[:phoneNumber]
      msg = TextMessage.new(params[:phoneNumber], params[:message])
      @response = msg.get_response
      render :xml => Builder::XmlMarkup.new.root { |x| x.result { |y| y.cdata! @response}}
    # check for twilio
    elsif params[:SmsSid]
      msg = TextMessage.new(params[:From], params[:Body])
      @response = msg.get_response
      xml = Builder::XmlMarkup.new
      xml.instruct!
      render :xml => xml.Response { |x| x.Sms @response}
    # check for tropos      
    elsif params[:session][:initialText]
      msg = TextMessage.new(params[:session][:from], params[:session][:initialText])
      @response = msg.get_response
      response = Tropo::Generator.say @response
      render :json => response
    end
  end

  def simulator
  end

end
