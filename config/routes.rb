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
  resources :organizations
  resources :text_contents

  get "/dashboard", :controller => :dashboard, :action => :index, :as => :dashboard_path

  resources :text_messages

  root :to => "dashboard#index"
    

end
