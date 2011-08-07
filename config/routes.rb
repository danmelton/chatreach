Sext3::Application.routes.draw do
  resources :keywords
  resources :reports

  # controller :helps do |help|
  #   help.sext "/help/sext", :controller :helps", :action => 'sext'
  # end
  resources :help, :controller => 'helps'
  resources :helps

  resources :faqs

  # controller :products do |products|
  #   products.products "/products", :action :index"
  #   products.poweron "/products/poweron", :action :poweron" 
  #   products.poweron "/products/poweron/:name", :action :poweron"
  #   products.sext "/products/sext", :action :sext"
  #   products.sext "/products/sext/:name", :action :sext"
  # end
  
  # controller :home do |home|
  #   home.home '/home', :controller => 'home', :action => 'index'
  #   home.about '/home/about', :controller => 'home', :action => 'about'    
  #   home.pricing '/home/pricing', :controller => 'home', :action => 'pricing'    
  #   home.signup '/home/contact', :controller => 'home', :action => 'contact'                
  #   home.signup '/home/webinars', :controller => 'home', :action => 'webinars'                    
  #   home.signup '/home/webinar', :controller => 'home', :action => 'webinar'                        
  #   home.thankyou '/home/thankyou', :controller => 'home', :action => 'thankyou'                    
  #   home.blog '/home/blog/:id/:title', :controller => 'home', :action => 'blog'                    
  #   home.blog '/home/blog', :controller => 'home', :action => 'blog'                        
  #   home.blog '/home/blog/rss', :controller => 'home', :action => 'rss'                            
  # end
  
  
  resources :profiles

  resources :settings, :collection => {:update => :post}
    
  match 'geo', :controller => 'geo', :action => 'index', :format => 'xml'

  resources :carriers

  resources :chatters
  resources :text_messages

  resources :text_contents, :collection => {:add => :any, :remove => :any, :simulator => :any}

  resources :oprofiles, :collection => {:add => :any, :remove => :any}

  resources :categories
  
  resources :tags

  resources :uprofiles
  
  resources 'organizations', :controller => 'oprofiles', :collection => {:verify => :any}

  match '/change_user', :controller => 'users', :action => 'change_user' 
  resources 'user', :controller => 'users' 
  resources 'manage_users', :controller => 'users' 

  resources :brands

  resources :dashboard
  match '/textmessage', :controller => 'text_messages', :action=>'index', :format=>'xml'
  match '/text_messages', :controller => 'text_messages', :action=>'index', :format=>'xml'
  resources :passwords, :controller => 'clearance/passwords',   :only       => [:new, :create]
  match  '/signup',    :controller => 'users',               :action => 'new'
  match  '/register',  :controller => 'users',               :action => 'new'
  match     '/login',     :controller => 'clearance/sessions',  :action => 'new'
  match    '/logout',    :controller => 'sessions',            :action => 'destroy'  
  match :session, :controller => 'clearance/sessions', :only=> [:new, :create, :destroy]
  
  root :to => "dashboard#index"
    

end
