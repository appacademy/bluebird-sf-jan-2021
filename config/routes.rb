Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # http_method 'path', to: 'controller#action'
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # post '/users', to: 'users#create'
  # patch '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'

  # resources :users, except: [:new, :edit] do 
  resources :users do 
    resources :chirps, only: [:index]
  end
  # resources :users, only: [:index, :show, :create, :update, :destroy]

end
