Rails.application.routes.draw do
  devise_for :users
  get 'home/home'

  root 'home#home'
end
