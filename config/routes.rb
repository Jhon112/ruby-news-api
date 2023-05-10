Rails.application.routes.draw do
  resources :articles, only: [:index] do
    collection do
      get :search
    end
  end
end