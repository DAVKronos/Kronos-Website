KronosWebsite::Application.routes.draw do
  
  resources :users
  
  get "pages/home"

  get "pages/contact"
  
  get "pages/about"

end
