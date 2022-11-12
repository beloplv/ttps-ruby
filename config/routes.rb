Rails.application.routes.draw do
  resources :sucursals
  devise_for :usuarios
  get 'index/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "index#home"
end
