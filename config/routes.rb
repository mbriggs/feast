Feast::Application.routes.draw do
  resources :orders

  devise_for :users, 
    :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }

  root :to => "orders#index"
end
