Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations",
                                    omniauth_callbacks: "omniauth_callbacks"}

  root 'static_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users do
    resources :friend_requests, only: [:index]
  end

  resources :friend_requests, only: [:create, :destroy, :update, :show]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

end
