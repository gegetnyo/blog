Rails.application.routes.draw do
  devise_for :users
  root to: "sentences#index"

  resources :sentences do
    collection do
      get :calendar
    end
  end
end
