Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :schools do
    resources :staffs
    resources :classrooms do
      resources :teachers
    end
    resources :courses do
      resources :teachers
      resources :sections
    end
  end

  root :to => 'homepage#index'


end
