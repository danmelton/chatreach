Sext3::Application.routes.draw do
  devise_for :users

  resources :brands do
      resources :settings
  end  


  resources :keywords
  resources :reports  


    
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

  match '/textmessage', :controller => 'text_messages', :action=>'index', :format=>'xml'
  match '/text_messages', :controller => 'text_messages', :action=>'index', :format=>'xml'
  
  root :to => "dashboard#index"
    

end
