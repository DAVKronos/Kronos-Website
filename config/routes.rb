Rails.application.routes.draw do
  get '/contact',     to: 'contacts#new'
  resources :contacts, only: [:new, :create]

  resources :mailinglists
  resources :aliases

  resources :agendaitemtype_eventtypes

  resources :agendaitemtypes

  devise_for :users, :path_prefix => 'site'

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
  get '/kronometers/:id/display/:style', to: "kronometers#display", as: "secure_kronometers_display"

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
    resources :comments
    collection do
      get 'agree'
    end
  end

  resources :agendaitems do
    member do
      get 'icalendar'
      get 'duplicate'
    end
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
    member do
      get 'recalculate'
    end
    collection do
      get 'records'
    end
  end

  resources :folders
  resources :announcements
  get 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  resources :pages
  get '/home', :to => 'pages#home'
  get '/nieuw', :to => 'pages#nieuw'
  get '/test', :to => 'pages#test'
  get '/admin', :to => 'pages#admin'
  get '/Game', :to => 'pages#game', as: 'game'
  get '/app/*page', :to => 'react#index'
  get '/app', :to => 'react#index'
  get '/:pt', :to => 'pages#titleshow'




  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      resources :mailinglists
      resources :aliases

      resources :photoalbums do
        resources :photos do
          member do
            get 'random'
          end
        end
      end

      resources :commissions
      resources :commission_memberships

      resources :agendaitemtype_eventtypes

      resources :agendaitemtypes do
        resources :eventtypes
      end

      resources :user_types

      resources :pages

      resources :folders do
        resources :kronometers
      end

      resources :kronometers

      resources :agendaitems do
        member do
          get 'icalendar'
          get 'duplicate'
        end
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
        resources :comments
      end

      resources :results, only: [:index, :create, :destroy] do
        member do
          get 'recalculate'
        end
        collection do
          get 'records'
        end
      end

      resources :users do
        resources :commissions
        collection do
          get 'birthdays'
        end
      end

      get '/abilities', :to => 'abilities#index'
    end
  end
  root :to => 'pages#home'

end
