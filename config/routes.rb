Sext3::Application.routes.draw do
  devise_for :users
  devise_for :users do
    get "/sign_out" => "devise/sessions#destroy"
    get "/sign_in" => "users/sessions#new"
  end  

  resources :brands do 
    resources :brand_admins, :only => [:create, :destroy]  
  end
  
  resources :categories

  get "/dashboard", :controller => :dashboard, :action => :index, :as => :dashboard_path

  # resources :keywords
  # resources :reports  
  # 
  # 
  #   
  # match 'geo', :controller => 'geo', :action => 'index', :format => 'xml'
  # 
  # resources :carriers
  # 
  # resources :chatters
  # resources :text_messages
  # 
  # resources :text_contents, :collection => {:add => :any, :remove => :any, :simulator => :any}
  # 
  # resources :oprofiles, :collection => {:add => :any, :remove => :any}
  # 
  # resources :categories
  # 
  # resources :tags
  # 
  # resources :uprofiles
  # 
  # resources 'organizations', :controller => 'oprofiles', :collection => {:verify => :any}
  # 
  # match '/change_user', :controller => 'users', :action => 'change_user' 
  # resources 'user', :controller => 'users' 
  # resources 'manage_users', :controller => 'users' 
  # 
  # match '/textmessage', :controller => 'text_messages', :action=>'index', :format=>'xml'
  # match '/text_messages', :controller => 'text_messages', :action=>'index', :format=>'xml'
  # 
  root :to => "dashboard#index"
    

end
