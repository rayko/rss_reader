RssReader::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks', :registrations => 'users/registrations' }

  namespace :user do
    post 'search' => 'search#search'
    get 'articles/full_list' => 'articles#full_list'
    get 'articles/starred' => 'articles#starred'
    get 'channels/list' => 'channels#list'
    resources :channels do
      resources :articles, :shallow => true, :only => [:index] do
        collection do
          get :mark_all
        end
        member do
          get :mark_as_read
          get :toggle_starred
        end
        resources :comments, :shallow => true, :only => [:index, :create]
      end
    end
  end

  match '*not_found', to: 'application#error_404' unless Rails.application.config.consider_all_requests_local
  root :to => 'application#index'
  ActiveAdmin.routes(self)
end
