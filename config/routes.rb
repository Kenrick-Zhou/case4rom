Case4rom::Application.routes.draw do
  root :to => 'users#index'
  get 'users/login' => 'users#login'
  get 'users/create' => 'users#create'
  get 'users/signup' => 'users#signUp'
  match ':controller(/:action(/:id))(.:format)'
  resources :users
end
