Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root to: "dashboards#index", as: :authenticated_root
    end

    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  get "dashboard", to: "dashboards#index", as: :dashboard
  get "up", to: "rails/health#show", as: :rails_health_check

  resources :food_entries, only: %i[index create edit update destroy]
  resources :food_suggestions, only: %i[index create destroy]
end
