Radd::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:edit, :update, :show]
  match 'users/edit' => 'registrations#edit', as: :user_root
  
  resources :friendships, only: [:create]
  match 'exchange/:token' => 'exchanges#show', as: :exchange

  match 'about' => 'home#about', as: :about
  root :to => "home#index"

  match '*id' => 'users#show', as: :public_user
end
