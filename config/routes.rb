Rails.application.routes.draw do
  root 'home#top'
  resources :posts
end
