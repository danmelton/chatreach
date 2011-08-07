class UprofilesController < ApplicationController
  layout "application"
  
  # GET /uprofiles
  # GET /uprofiles.xml
  def index
    @uprofiles = Uprofile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uprofiles }
    end
  end

  # GET /uprofiles/1
  # GET /uprofiles/1.xml
  def show
    @uprofile = Uprofile.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @uprofile }
    end
  end

  # GET /uprofiles/new
  # GET /uprofiles/new.xml
  def new
    @uprofile = current_user.uprofile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @uprofile }
    end
  end

  # GET /uprofiles/1/edit
  def edit
    @uprofile = current_user.uprofile
  end

  # POST /uprofiles
  # POST /uprofiles.xml
  def create
    @uprofile = current_user.uprofile.new(params[:uprofile])

    respond_to do |format|
      if @uprofile.save
        flash[:notice] = 'Uprofile was successfully created.'
        format.html { redirect_to(@uprofile) }
        format.xml  { render :xml => @uprofile, :status => :created, :location => @uprofile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @uprofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uprofiles/1
  # PUT /uprofiles/1.xml
  def update
    @uprofile = current_user.uprofile

    respond_to do |format|
      if @uprofile.update_attributes(params[:uprofile])
        flash[:notice] = 'Uprofile was successfully updated.'
        format.html { redirect_to(edit_uprofile_path(@uprofile)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @uprofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uprofiles/1
  # DELETE /uprofiles/1.xml
  def destroy
    @uprofile = current_user.uprofile.find(params[:id])
    @uprofile.destroy

    respond_to do |format|
      format.html { redirect_to(uprofiles_url) }
      format.xml  { head :ok }
    end
  end
end
