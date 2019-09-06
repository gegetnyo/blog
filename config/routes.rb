Rails.application.routes.draw do
  devise_for :users
  root to: "sentences#index"

  resources :sentences
end
