module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
  
  def tag_cloud(tags, classes)
    max, min = 0, 0
    tags.each { |t|
      max = t.count.to_i if t.count.to_i > max
      min = t.count.to_i if t.count.to_i < min
    }

    divisor = ((max - min) / classes.size) + 1

    tags.each { |t|
      yield t.name, classes[(t.count.to_i - min) / divisor]
    }
  end
  
  def mobile
    if is_mobile?
      "<h1><a href='?mobile=1'>Click Here to View in Mobile Mode >></a></h1>"
    else
      
    end
  end
  
  def nonbrand_users(brand)
    users = User.all - brand.admins
    return users.map { |x| [x.email, x.id]}
  end
  
  def not_selected_brands(org)
    brands = Brand.all - org.brands
    if !brands.blank?
    brands.map { |x| [x.name, x.id]}
    end
  end
  
  def not_selected_brand(brand)
    brands = Brand.where("id != #{brand.id}")
    if !brands.blank?
    brands.map { |x| [x.name, x.id]}
    end
  end
  
  def brand_setting_name(name)
    case name
    when "welcome"
      "Welcome"
    when "organization_not_found"
      "Organization Not Found Return Text"
    when "info_not_found"  
      "Information Not Return Text"
    when "distance_for_organization"
      "Distance in Miles for Organization Search"  
    when "provider"  
      "SMS Provider"      
    when "phone_number"
      "Phone Number or Short Code"        
    when "api_key"
      "API Key if needed"      
    when "provider_secret_key"
      "Secret Key if needed"            
    end
  end
  
  def form_field_type_for_settings(ff)
    case ff.object.name
    when "welcome"                                                                                   
      ff.text_area :setting, :class => "counting expanding #{ff.object.name}", :id => ff.object.name, :maxLength=>"140"
    when "organization_not_found"                                                                          
      ff.text_area :setting, :class => "counting expanding #{ff.object.name}", :id => ff.object.name, :maxLength=>"140"
    when "info_not_found"                                                                            
      ff.text_area :setting, :class => "counting expanding #{ff.object.name}", :id => ff.object.name, :maxLength=>"140"
    when "provider"
      ff.select :setting, [["Select a Provider",""],["Text Caster", "Text Caster"], ["Tropos", "Tropos"], ["Twilio", "Twilio"]]
    else
      ff.text_field :setting, :class => "counting expanding #{ff.object.name}"
    end
  end
  
  def character_count?(ff)
    case ff.object.name
    when "welcome"
      '<p class="charLeft">Characters Left: <span id="' + ff.object.name + 'Down"></span>'
    when "clinic_not_found"
      '<p class="charLeft">Characters Left: <span id="' + ff.object.name + 'Down"></span>'
    when "info_not_found"  
      '<p class="charLeft">Characters Left: <span id="' + ff.object.name + 'Down"></span>'
    else
    end
  end
  

end
