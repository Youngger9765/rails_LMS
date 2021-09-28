Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/rails_admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :schools do
    resources :staffs
    resources :students
    resources :classrooms do
      resources :teachers
      resources :courses
    end
    resources :courses do
      resources :teachers
      resources :sections
    end
  end

  root :to => 'homepage#index'

  namespace :admin do
    resources :schools do
      resources :classrooms
      resources :courses do
        resources :sections do
          post :new_content, on: :member
          post :edit_content, on: :member
          delete :delete_content, on: :member
          get :quiz_content, on: :member
          post :summit_quiz, on: :member
        end
      end
    end
    put '/contents/sort', to: 'contents#sort'
    put '/sections/sort', to: 'sections#sort'
 end

end
