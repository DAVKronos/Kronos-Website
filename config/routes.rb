Rails.application.routes.draw do
  get '/contact',     to: 'contacts#new'
  resources :contacts, only: [:new, :create]

  resources :mailinglists
  resources :aliases

  resources :agendaitemtype_eventtypes

  resources :agendaitemtypes

  devise_for :users
  resources :users do
    member do
      get 'editpassword'
    end
  end

  resources :photos
  resources :comments
  resources :tags
  resources :photoalbums do
    member do
      get 'publish'
    end
    resources :photos
  end
  resources :kronometers do
    collection do
      get 'labels'
    end
  end
  resources :news_items

  resources :commissions
  resources :commission_memberships
  
  resources :eventtypes do
    member do
      get 'copy'
    end
  end

  resources :newsitems do
    member do
      get 'agreed'
    end
    collection do
      get 'agree'
    end
  end

  resources :agendaitems do
    resources :events
    resources :comments
    resources :subscriptions
    collection do
      get 'archief'
      get 'wedstrijden'
      get 'new_result'
      post 'create_result'
    end
  end
  resources :results, only: [:index, :create, :destroy] do
    collection do
      get 'records'
    end
  end
  
  resources :announcements
  get 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  resources :pages
  get '/home', :to => 'pages#home'
  get '/nieuw', :to => 'pages#nieuw'
  get '/test', :to => 'pages#test'
  get '/admin', :to => 'pages#admin'
  get '/Lustrum Alumnidag', :to => 'pages#lustrum_signup', as: 'lustrum_signup'
  post '/lustrum_alumnidag', :to => 'pages#lustrum_signup_new', as: "new_lustrum_signup"
  post '/lustrum_alumnidag_pass', :to => 'pages#lustrum_enter_password', as: "lustrum_password"
  get '/:pt', :to => 'pages#titleshow'
  
  root :to => 'pages#home'
end
