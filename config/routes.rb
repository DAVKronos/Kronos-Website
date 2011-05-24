KronosWebsite::Application.routes.draw do
  
  resources :users
  
  match '/home', :to => 'pages#home'

  get "pages/contact"
  
  get "pages/about"
  
  root :to => 'pages#home'

end
