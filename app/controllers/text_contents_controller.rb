class TextContentsController < ApplicationController
  before_filter [:authenticate_user!, :brand_admin, :tag_list_name]
  layout "application"
  # GET /textcontents
  # GET /textcontents.xml
  def index
    if params[:type] == 'my'
      @view_type = "my"
      @text_contents = current_user.account.text_contents.with_brand(session[:brand])
    elsif params[:type] == 'unlinked'
      @view_type = "unlinked"
      if !current_user.account.text_contents.with_brand(session[:brand]).published.blank?
        textcontent = current_user.account.text_contents.with_brand(session[:brand]).published.map(&:id).join(",")      
        @text_contents = TextContent.with_brand(session[:brand]).unlinked(textcontent).published
      else
        @text_contents = TextContent.with_brand(session[:brand]).published
      end
    else
      @view_type = "linked"      
      @text_contents = current_user.account.text_contents.with_brand(session[:brand]).published
    end

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @text_contents }
    end
  end

  # GET /textcontents/new
  # GET /textcontents/new.xml
  def new
    @textcontent = TextContent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @textcontent }
    end
  end

  # GET /textcontents/1/edit
  def edit
    @textcontent = TextContent.find(params[:id])
  end

  # POST /textcontents
  # POST /textcontents.xml
  def create
    @text_content = current_user.text_contents.new(params[:text_content])
    @text_content.brand = Brand.find(session[:brand])
    respond_to do |format|
      if @text_content.save
        @text_content.accounts << current_user.account
        flash[:notice] = 'Text Content was successfully created.'
        format.html { redirect_to(text_contents_path) }
        format.xml  { render :xml => @textcontent, :status => :created, :location => @textcontent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @text_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /textcontents/1
  # PUT /textcontents/1.xml
  def update

    @textcontent = TextContent.find(params[:id])

    respond_to do |format|
      if @textcontent.update_attributes(params[:text_content])
        flash[:notice] = 'Text Content was successfully updated.'
        format.html { redirect_to(text_contents_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @text_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /textcontents/1
  # DELETE /textcontents/1.xml
  def destroy
    @text_content = TextContent.find(params[:id])
    @text_content.destroy

    respond_to do |format|
      format.html { redirect_to(text_contents_url) }
      format.xml  { head :ok }
    end
  end
  
  def add
    @text_content = TextContent.find(params[:id])
    
    if !@text_content.nil?
      current_user.account.text_contents << TextContent.find(params[:id])
      flash[:notice] = "Text Content was added."
    end
  end
  
  def remove
    @text_content = TextContent.find(params[:id])
    
    if !@text_content.nil?
      current_user.account.account_texts.find_by_text_content_id(params[:id]).delete
      @text_content.update_attributes(:published => false)
      flash[:notice] = "Text Content was removed."
    end
  end
  

end
