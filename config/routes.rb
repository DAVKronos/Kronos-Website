KronosWebsite::Application.routes.draw do
  #match '/uitslagen/', to: 'results#index' 
  #match '/uitslagen/records', :to => 'results#records', :as => 'result_frontpage_records'
  #match '/rebuildmailinglists', :to => 'users#update_mailinglists'
  #match '/eventtypes/:id/copy', :to => 'eventtypes#copy'
  #match '/agendaitems/archief', :to => 'agendaitems#archief'
  #match '/agendaitems/dag/:day', :to => 'agendaitems#perdag', :as => :perdag
  #match '/wedstrijden', :to => 'agendaitems#wedstrijden'
  #match '/agendaitems/new_result', :to => 'agendaitems#new_result', :as => 'agendaitem_new_result'
  #match '/agendaitems/create_result', :to => 'agendaitems#create_result', via: [:post]
  #match '/agenda', :to => 'agendaitems#index'
  #match '/chatmessages/archief', :to => 'chatmessages#archief'
  #match '/newsitems/agree', :to => 'newsitems#agree'
  #match '/newsitems/agreed/:id', :to => 'newsitems#agreed'
#    resources :results
#  resources :events, only: [:index, :show, :destroy] do
#    resources :results
#  end

  match '/contact',     to: 'contacts#new',             via: 'get'
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
  match 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  resources :pages
  match '/home', :to => 'pages#home'
  match '/nieuw', :to => 'pages#nieuw'
  match '/test', :to => 'pages#test'
  match '/admin', :to => 'pages#admin'
  match '/:pt', :to => 'pages#titleshow'
  
  root :to => 'pages#home'
end
