Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do

      resources :mailinglists
      resources :aliases

      resources :photoalbums do
        resources :photos do
          member do
            get 'random'
          end
        end
      end

      resources :commissions do
        resources :commission_memberships
      end
      

      resources :agendaitemtype_eventtypes

      resources :agendaitemtypes do
        resources :eventtypes
      end

      resources :user_types

      resources :pages

      resources :folders do
        resources :kronometers
      end

      get '/kronometers/:id/display/:style', to: "kronometers#display", as: "secure_kronometers_display"
      resources :kronometers

      resources :announcements do
        collection do
          get 'current'
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
  # for kronometer files
  
  get '/*page', :to => 'react#index'
  root :to => 'react#index'

end
