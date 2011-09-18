Sext3::Application.routes.draw do
  devise_for :users
  devise_for :users do
    get "/sign_out" => "devise/sessions#destroy"
    get "/sign_in" => "users/sessions#new"
  end  

  resources :brands do 
    resources :brand_admins, :only => [:create, :destroy]  
    resources :brand_organizations, :only => [:create, :destroy]
  end
  
  resources :categories
  resources :tags
    
  resources :tag_typos, :only => [:create, :destroy]    
  resources :chatters, :only => [:index, :show]      
  
  resources :organizations

  resources :text_contents
  
  get "simulator",:controller => :text_contents, :action => :simulator

  get "/dashboard", :controller => :dashboard, :action => :index, :as => :dashboard_path
  post "/dashboard", :controller => :dashboard, :action => :index, :as => :dashboard_path

  # for text caster and twilio  
  get "/textmessage",:controller => :text_messages, :action => :index
  get "/text_messages",:controller => :text_messages, :action => :index  
  
  # for tropo
  post "/textmessage",:controller => :text_messages, :action => :index  
  post "/text_messages",:controller => :text_messages, :action => :index  
  
  get "/texts", :controller => :texts, :action => :index, :as => :texts
  post "/texts", :controller => :texts, :action => :index, :as => :text_histories
 
  resources :users

  root :to => "dashboard#index"
    

end
