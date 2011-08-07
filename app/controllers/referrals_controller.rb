class ReferralsController < ApplicationController
  before_filter [:authenticate, :tag_list_name]
  layout "application"
  
  # GET /referrals
  # GET /referrals.xml
  def index
    if params[:type] == 'my'
      @view_type = "my"
      @referrals = current_user.referrals.with_brand(session[:brand])
    else
      @referrals = current_user.account.referrals.with_brand(session[:brand])
    end
  end

  # GET /referrals/1
  # GET /referrals/1.xml
  def show
    @referral = current_user.account.referrals.find(params[:id])
    sub_domain = current_user.account.brand_settings.with_brand(session[:brand]).find_by_name('subdomain').setting
    domain = current_user.account.brand_settings.with_brand(session[:brand]).find_by_name('domain').setting
    @domain = "http://#{sub_domain}.#{domain}/r/#{@referral.code}"
  end

  # GET /referrals/new
  # GET /referrals/new.xml
  def new
    @referral = Referral.new
  end
  
  def single
    @referral = Referral.new
    @articles = current_user.account.articles.with_brand(session[:brand])
    @videos = Video.with_brand(session[:brand])
    @blogs = FeedEntry.with_brand(session[:brand])
    @clinics = Oprofile.available(current_user.account.id, session[:brand]) 
  end
  

  # GET /referrals/1/edit
  def edit
    @referral = current_user.account.referrals.find(params[:id])
    sub_domain = current_user.account.brand_settings.with_brand(session[:brand]).find_by_name('subdomain').setting
    domain = current_user.account.brand_settings.with_brand(session[:brand]).find_by_name('domain').setting
    @referral_url = "http://#{domain}/r/#{@referral.code}"
    if @referral.rcontent
      @articles = current_user.account.articles.with_brand(session[:brand])
      @videos = Video.with_brand(session[:brand])
      @blogs = FeedEntry.with_brand(session[:brand])
      @clinics = Oprofile.available(current_user.account.id, session[:brand])      
      render "referrals/edit_single"
    else
      render "referrals/edit"
    end
  end

  # POST /referrals
  # POST /referrals.xml
  def create
    if params[:referral][@tag_list_name.to_s]
      params[:referral][@tag_list_name.to_s] = params[:referral][@tag_list_name.to_s].join(", ") unless params[:referral][@tag_list_name.to_s].blank?
    end
    @referral = current_user.account.referrals.new(params[:referral])
    @referral.brand = Brand.find(session[:brand])
    @referral.user = current_user
    @referral.account = current_user.account
    @referral.code = (1..5).collect { (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }.join
      if @referral.save
        flash[:notice] = 'Referral was successfully created.'
        if @referral.rcontent
          redirect_to(edit_referral_path(@referral))          
        else  
          redirect_to(edit_referral_path(@referral))
        end
      else
        render :action => "new"
      end

  end

  # PUT /referrals/1
  # PUT /referrals/1.xml
  def update
    @referral = current_user.account.referrals.find(params[:id])
    params[:referral][@tag_list_name.to_s] = params[:referral][@tag_list_name.to_s].join(", ") unless params[:referral][@tag_list_name.to_s].blank?

      if @referral.update_attributes(params[:referral])
        flash[:notice] = 'Referral was successfully updated.'
        redirect_to(edit_referral_path(@referral))
      else
        render :action => "edit"
      end
  end

  # DELETE /referrals/1
  # DELETE /referrals/1.xml
  def destroy
    @referral = current_user.account.referrals.find(params[:id])
    @referral.destroy
    flash[:notice] = 'Referral was successfully destroyed.'
    redirect_to(referrals_url)
  end
  
  private

  def find_rcontent
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
  
end
