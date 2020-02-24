Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  resources :posts
end
