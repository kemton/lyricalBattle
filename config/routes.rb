LyricalBattle::Application.routes.draw do

  get "messages/index"
  get 'messages/show/:id', to: 'messages#show'

  # omniauth-facebook authentication
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  root 'battles#index'

  resources :messages
  resources :battles

end
