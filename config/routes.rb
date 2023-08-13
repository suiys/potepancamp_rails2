Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/', to: 'home#top', as: 'root'

  get 'users/profile', to: 'users#profile', as: 'profile'
  get 'users/profile/edit', to: 'users#edit', as: 'edit_profile'
  get 'users/account', to: 'users#account', as: 'account'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: :update
end
