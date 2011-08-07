class BrandSextSettings
  
  def initialize(account)
    @account = account
    @brand = Brand.find_by_name('Sext')
    account.account_brands.create(:brand => @brand )
    self.settings
    self.add_contents(account)
  end
  
  def settings
    @account.brand_settings.create(:name=>"keyword", :setting => "", :brand => @brand)
    @account.brand_settings.create(:name=>"description", :setting => "", :brand => @brand)
    @account.brand_settings.create(:name=>"clinic not found", :setting => "We couldn't find a clinic. Give us a call at this number.", :brand => @brand)
    @account.brand_settings.create(:name=>"info not found", :setting => "We couldnt find that info, maybe you misspelled it?", :brand => @brand)
    @account.brand_settings.create(:name=>"subdomain", :setting => "newmedia", :brand => @brand)
    @account.brand_settings.create(:name=>"domain", :setting => "newmedia.yourdomainname.org", :brand => @brand)
    @account.brand_settings.create(:name=>"contact", :setting => "contact us", :brand => @brand)                    
    @account.brand_settings.create(:name=>"about", :setting => "about us", :brand => @brand)                    
    @account.brand_settings.create(:name=>"for parents", :setting => "for parents", :brand => @brand)                            
  end
  
  def add_contents(account)
    TextContent.with_brand(2).each do |tc|
      account.text_contents << tc
    end
  end
  
end