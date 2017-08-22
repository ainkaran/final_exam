Rails.application.routes.draw do
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

  get('/', {to: 'welcome#index', as: 'home'})

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end

  resources :auctions, except: [:new, :edit] do
    resources :bids, only: [:create, :destroy]
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :auctions, only: [:create, :show, :index, :destroy, :update]
      resources :tokens, only: [:create]
    end
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :bids, only: [:create, :destroy, :index]
      resources :tokens, only: [:create]
    end
  end

=begin
  get 'sessions/create'

  get 'sessions/destroy'

  get 'bids/create'

  get 'bids/destroy'

  get 'auctions/create'

  get 'auctions/show'

  get 'auctions/index'

  get 'auctions/destroy'

  get 'auctions/update'

=end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
