class DomainsController < ActionController::Base
  
  def index
    if !BrandSetting.with_domain(request.host).blank?
      brand = BrandSetting.with_domain(request.host).first.brand.name
      session[:domain] = request.host
      redirect_to(:controller => "/#{brand.downcase}")
    elsif request.host.include?('chatreach')
      session[:domain] = request.host      
      redirect_to(home_path)  
    elsif find_domain(request.host)
      domain = find_domain(request.host)
      session[:domain] = domain.setting
      redirect_to(:controller => "/#{domain.brand.name.downcase}")      
      else
        redirect_to(home_path)      
      end
  end
  
  private
  
    def find_domain(current_domain)
      BrandSetting.domains.each do |domain|
        if domain.setting.include?(current_domain)
          return domain
        end
      end
      false
    end
  
end