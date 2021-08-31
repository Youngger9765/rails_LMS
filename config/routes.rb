Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :schools do
    resources :staffs, :controller => 'staffs'
    resources :classrooms, :controller => 'classrooms' do
      resources :teachers, :controller => 'teachers'
    end
    resources :courses, :controller => 'courses' do
      resources :teachers, :controller => 'course_teachers'
    end
  end

  root :to => 'homepage#index'


end
