Randori::Application.routes.draw do
  resources :transacts
  devise_for :users

  root :to => "transacts#new"
end
