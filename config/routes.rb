Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :audios, only: [:create, :show]
end
