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
  

end
