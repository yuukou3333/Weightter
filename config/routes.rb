Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  devise_for :users
  root 'home#top'
  resources :posts

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :show, :create]



  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

end
