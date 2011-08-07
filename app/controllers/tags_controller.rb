class TagsController < ApplicationController
  before_filter :authenticate
  layout "application"
  protect_from_forgery :only => [:delete]
  
  # POST /categories
  # POST /categories.xml
  def create
    tag = params[:tag][:name]
    @tag = Tag.find_or_create_by_name(tag)
    @tag.brands << Brand.find(session[:brand])
    @tag_list_name = Brand.find(session[:brand]).name.downcase.to_s + "_list"

    respond_to do |format|
        format.js {render :html => @tag}
        format.html { redirect_to(@tag) }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
    end
  end
  
end