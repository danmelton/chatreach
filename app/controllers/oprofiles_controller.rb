class OprofilesController < ApplicationController
  layout "application"
  before_filter :authenticate, :except => [:show, :claim, :verify]
  before_filter :tag_list_name
  # GET /oprofiles
  # GET /oprofiles.xml
  def index
    if params[:type] == 'unlinked'
      @view_type = "unlinked"
      if !current_user.account.account_organizations.with_brand(session[:brand]).blank?
        oprofile = current_user.account.account_organizations.with_brand(session[:brand]).map(&:id).join(",")      
        @oprofiles = Oprofile.unlinked(oprofile)
      else
        @oprofiles = Oprofile.all
      end
    else
      @view_type = "linked"      
      oprofile = current_user.account.account_organizations.with_brand(session[:brand]).map(&:oprofile_id).join(",")      
      @oprofiles = Oprofile.linked(oprofile)
      @view_type = "linked"      
      @oprofiles = current_user.account.oprofiles.with_brand(session[:brand])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oprofiles }
    end
  end

  # GET /oprofiles/1
  # GET /oprofiles/1.xml
  def show
    if params[:id]
      @oprofile = Oprofile.find(params[:id])
    elsif params[:name]
      @oprofile = Oprofile.find_by_name(params[:name])  
    end
    
    @map = GMap.new("map_div")
	  @map.control_init(:large_map => true,:map_type => true)
	  @map.center_zoom_init([@oprofile.geom.lat,@oprofile.geom.lon],15)
	  @map.overlay_init(GMarker.new([@oprofile.geom.lat,@oprofile.geom.lon],:title => @oprofile.name, :info_bubble => @oprofile.address))


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oprofile }
    end
  end

  # GET /oprofiles/new
  # GET /oprofiles/new.xml
  def new
    @oprofile = current_user.account.oprofiles.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oprofile }
    end
  end

  # GET /oprofiles/1/edit
  def edit
    if Oprofile.find(params[:id]) == current_user.account.programs.first
      @oprofile = current_user.account.programs.first
    else
      @oprofile = current_user.account.oprofiles.find(params[:id])
    end
  end

  # POST /oprofiles
  # POST /oprofiles.xml
  def create
    if params[:owner]=='yes'
      params[:oprofile][@tag_list_name.to_s] = params[:oprofile][@tag_list_name.to_s].join(", ") unless params[:oprofile][@tag_list_name.to_s].blank?
      @oprofile = current_user.account.programs.new(params[:oprofile])
      respond_to do |format|
        if @oprofile.save
          if session[:brand]
            current_user.account.account_organizations.create(:oprofile => @oprofile, :brand => Brand.find(session[:brand]))
            flash[:notice] = "#{@oprofile.name} was added."
          end

          flash[:notice] = 'Oprofile was successfully created.'
          format.html { redirect_to(organizations_path) }
          format.xml  { render :xml => @oprofile, :status => :created, :location => @oprofile }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @oprofile.errors, :status => :unprocessable_entity }
        end
      end
    else
      @account = Account.create(:name => params[:oprofile][:name], :code => random_alpha(5))
      params[:oprofile][@tag_list_name.to_s] = params[:oprofile][@tag_list_name.to_s].join(", ") unless params[:oprofile][@tag_list_name.to_s].blank?
      @oprofile = current_user.account.custodials.new(params[:oprofile])
      @oprofile.owner = @account
      respond_to do |format|
        if @oprofile.save
          if session[:brand]
            current_user.account.account_organizations.create(:oprofile => @oprofile, :brand => Brand.find(session[:brand]))
            flash[:notice] = "#{@oprofile.name} was added."
          end
          @user = @account.users.new
          @password = @account.code

          flash[:notice] = 'Oprofile was successfully created.'
          format.html { render "outside_new", :locals =>{:user => @user, :password => @password }}
          format.xml  { render :xml => @oprofile, :status => :created, :location => @oprofile }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @oprofile.errors, :status => :unprocessable_entity }
        end
      end    
    end
    
  end

  # PUT /oprofiles/1
  # PUT /oprofiles/1.xml
  def update
    if Oprofile.find(params[:id]) == current_user.account.programs.first
      @oprofile = current_user.account.programs.first
      profile = edit_organization_path(@oprofile)
    else
      @oprofile = current_user.account.oprofiles.find(params[:id])
      profile = organizations_path
    end
    params[:oprofile][@tag_list_name.to_s] = params[:oprofile][@tag_list_name.to_s].join(", ") unless params[:oprofile][@tag_list_name.to_s].blank?

    respond_to do |format|
      if @oprofile.update_attributes(params[:oprofile])
        flash[:notice] = 'Oprofile was successfully updated.'
        format.html { redirect_to(profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oprofile.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def claim
    if request.post?
      if current_user
        flash[:notice] = "You can't claim an organization. You already have one!"
        render 'claim'
      else  
        if params[:code] == Oprofile.find(params[:id]).owner.code
          @user = Oprofile.find(params[:id]).owner.users.first
          render 'users/verify', :locals =>{:user => @user} 
        else
          flash[:notice] = "Incorrect Code"
          render 'claim'
        end
      end
    else  
    @oprofile = Oprofile.find(params[:id]) 
    @code = params[:code]
    render "claim"
    end
  end
  
  def verify
    @user = User.find(params[:user][:id])
    @user.uprofile.update_attributes(params[:uprofile])
    @user.password = params[:user][:password]
    @user.admin = true
    @user.account.programs.first.update_attributes(:custodian => nil)
    @user.account.update_attributes(:code => '')
    @user.save
    @user.confirm_email!
    sign_in(@user)
    redirect_to('/dashboard')
  end
  
  def add
    @oprofile = Oprofile.find(params[:id])
    
    if !@oprofile.nil?
      current_user.account.account_organizations.create(:oprofile => @oprofile, :brand => Brand.find(session[:brand]))
      flash[:notice] = "#{@oprofile.name} was added."
    end
  end
  
  def remove
    @oprofile = Oprofile.find(params[:id])
    @account_organization = current_user.account.account_organizations.find(:first, :conditions => [ "brand_id = ? and oprofile_id = ?", session[:brand], params[:id]])
    
    if !@account_organization.nil?
      @account_organization.delete
      flash[:notice] = "#{@oprofile.name} was removed."
    end
  end

  def destroy
    if current_user
    @oprofile = Oprofile.find(params[:id])
    @oprofile.destroy
    flash[:notice] = "Organization deleted"
    end

    respond_to do |format|
      format.html { redirect_to(organizations_path) }
      format.xml  { head :ok }
    end
  end
  
end
