class Demo
  
    def initialize
      # Create the Account
      account = create_account
      # Create a Profile for the Account
      create_oprofile(account)

      # Attach the Sext Brand
      setup(account, 'Sext', subdomain='askdan', domain='askdan.chatreach.com', setting1='askdan', setting2='Welcome to the Ask Dan Text Line. Text back works like hiv, herpes, pills, birth control.')

      # Add three organizations
      # Link the organizations in PowerOn and Sext  
    end
  
    def create_account
      Account.find_or_create_by_name('Demo')
    end
    
    def create_oprofile(account)
      if !account.programs.blank?      
        account.programs.first.delete
      end  
      account.programs.create!(:name => "Demo", :address => "613 Sandusky Ave" , :city => "kansas City", :state => "MO", :zip => "66101", :owner => account, :about => "We offer HIV Testing, counseling and misc things for gay men")
    end
    
    def create_uprofile(account)
      account.users.delete_all
      if account.users.find_by_email('demo@chatreach.com').nil?
      account.users.create!(:email => 'demo@chatreach.com', :password=>"demo", :admin => false)
      User.last.confirm_email!
      User.last.create_uprofile(:first_name => "Demo", :last_name => "Demo")
      end
    end  

    def setup(account, brandis, subdomain='', domain='', setting1='', setting2='')
      if brandis=='Sext'
        brand = Brand.find_by_name('sext')
        if !account.brands.find_by_name(brandis).nil?
           account.brand_settings.with_brand(brand.id).delete_all
           account.account_brands.find_by_brand_id(brand.id).delete
        end
        BrandSextSettings.new(account)
        BrandSetting.with_account(account.id).with_brand(brand.id).with_name('description').first.update_attributes(:setting => 'Welcome the Sext Line, text back a word like hiv, herpes or pregnancy')
        BrandSetting.with_account(account.id).with_brand(brand.id).with_name('keyword').first.update_attributes(:setting => setting1)
      end
      BrandSetting.with_account(account.id).with_brand(brand.id).with_name('subdomain').first.update_attributes(:setting => subdomain)
      BrandSetting.with_account(account.id).with_brand(brand.id).with_name('domain').first.update_attributes(:setting => domain)
    end
  
end