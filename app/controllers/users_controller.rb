class UsersController < Clearance::UsersController
  before_filter :redirect_to_root, :only => [:new, :create], :if => :signed_in?
  filter_parameter_logging :password
  before_filter :admin?, :only => [:destroy, :create, :new]
  
  def index
    @users = current_user.account.users
  end
  
  def change_user
    if current_user.super? or User.find(session[:super]).super?
      session[:super] = current_user.id unless !session[:super].blank?
      sign_in(User.find(params[:users]))
      flash[:notice] = 'Changed User.'
    end 
    redirect_to('/dashboard')
  end

  def new
    @user = ::User.new(params[:user])
    render :template => 'users/new'
  end
  
  def create
    @user = ::User.new params[:user]
    if params[:account].blank?
    @user.account = current_user.account 
    @user.email_confirmed = true
    path = users_url
    templ = "users/new" 
    else
    @user.account = Account.find(params[:account])
    path = organizations_url
    templ = "oprofiles/outside_new" 
    end
    if @user.save
      @user.create_uprofile(params[:uprofile]) unless params[:uprofile].blank?
      redirect_to('/manage_users')
    else
      render :template => templ
    end
  end
  
  def destroy
    @user = current_user.account.users.find(params[:id])
    if @user.inactive == true
    @user.update_attributes(:inactive => false)
    else
    @user.update_attributes(:inactive => true)
    end
    @user.save

    respond_to do |format|
      format.html { redirect_to('/manage_users') }
      format.xml  { head :ok }
    end
  end

  private

  def redirect_to_root
    '/dashboard'
  end
  
end
