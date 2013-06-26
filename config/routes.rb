Case4rom::Application.routes.draw do
  root :to => 'users#index'
  get 'users/login' => 'users#login'
  post 'users/create'
  post 'users/signUp' => 'users#signUp'
  post 'users/forgot_password' => 'users#forgot_password'
  match ':controller(/:action(/:id))(.:format)'
  resources :users
end
