Rails.application.routes.draw do
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :pages, only: [] do
    collection do
      get :home
      get :detail
      get :files
      get :file_show
    end
  end

  resources :torrent_files, only: [:index, :new] do
    collection do
      post :download
    end
  end

  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq' 
end
