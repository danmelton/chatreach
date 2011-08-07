class BrandsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin, :except => :show
  layout "application"
  
  def show
    #creates a session for that brand
    session[:brand] = current_user.account.brands.find(params[:id]).id
    redirect_to '/dashboard'
  end
  
  def index
    @brands = Brand.all
  end

end
