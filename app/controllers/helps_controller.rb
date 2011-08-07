class HelpsController < ApplicationController
  before_filter :admin, :except => :show
  before_filter :authenticate, :except => :show
  layout "application"
  # GET /helps
  # GET /helps.xml
  def index
    @helps = Help.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @helps }
    end
  end
  
  def sext
    brand = Brand.find_by_name('sext').id
    @helps = Help.with_brand(brand)
    @help_all =  Help.with_brand(0)
    @featured = Help.with_brand(brand).feature(5)
  end

  # GET /helps/1
  # GET /helps/1.xml
  def show
    @help = Help.find(params[:id])
    brand = @help.brand_id
    if brand.nil?
      brand = '0'
    end
    
    @related = Help.with_brand(brand)
    @recent = Help.with_brand(brand).recent
    @featured = Help.with_brand(brand).feature(5)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @help }
    end
  end

  # GET /helps/new
  # GET /helps/new.xml
  def new
    @help = Help.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @help }
    end
  end

  # GET /helps/1/edit
  def edit
    @help = Help.find(params[:id])
  end

  # POST /helps
  # POST /helps.xml
  def create
    @help = current_user.helps.new(params[:help])

    respond_to do |format|
      if @help.save
        flash[:notice] = 'Help was successfully created.'
        format.html { redirect_to(@help) }
        format.xml  { render :xml => @help, :status => :created, :location => @help }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @help.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /helps/1
  # PUT /helps/1.xml
  def update
    @help = current_user.helps.find(params[:id])

    respond_to do |format|
      if @help.update_attributes(params[:help])
        flash[:notice] = 'Help was successfully updated.'
        format.html { redirect_to(@help) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @help.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /helps/1
  # DELETE /helps/1.xml
  def destroy
    @help = current_user.helps.find(params[:id])
    @help.destroy

    respond_to do |format|
      format.html { redirect_to(helps_url) }
      format.xml  { head :ok }
    end
  end
end
