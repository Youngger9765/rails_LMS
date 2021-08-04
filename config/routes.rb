Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :schools do
    resources :school_staffs, :controller => 'school_school_staffs'
    resources :classrooms, :controller => 'school_classrooms' do
      resources :teachers, :controller => 'classroom_teachers'
    end
  end

  root :to => 'homepage#index'


end
