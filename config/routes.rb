Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/', to: 'home#top', as: 'root'

  get 'users/profile', to: 'users#profile', as: 'profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
