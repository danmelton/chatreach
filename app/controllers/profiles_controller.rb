class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  layout "application"

  # GET /profiles
  # GET /profiles.xml
  def index
    @profiles = current_user.account.profiles.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = current_user.account.profiles.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = current_user.account.profiles.new(params[:profile])
    @profile.brand = Brand.find(session[:brand])
    respond_to do |format|
      if @profile.save
        flash[:notice] = 'Profile was successfully created.'
        format.html { redirect_to(profiles_path) }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = current_user.account.profiles.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to(profiles_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = current_user.account.profiles.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end