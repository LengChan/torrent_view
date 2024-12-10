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
      get :show_file
    end
  end
  # get 'torrent_files/', to: 'torrent_files#show', as: 'video'


  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq' 
end
