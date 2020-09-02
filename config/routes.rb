Rails.application.routes.draw do
  devise_for :users #先頭に
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  root 'home#top'
  get 'home/about'

end