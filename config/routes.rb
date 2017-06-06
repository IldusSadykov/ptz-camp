require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }

  authenticate :user, lambda{ |u| u.admin? } do
    get :admin, to: 'admin/site#home'

    namespace :admin do
      mount Sidekiq::Web => '/sidekiq'
      resources :messages, only: [:index, :create, :new]
      resources :day_schedules, only: [:edit, :update]
      resources :camps
    end
  end

  scope ':slug' do
    get '', to: 'camps#show', as: :camp
    resource :schedule, controller: :schedule, only: :show
  end

  root to: 'site#home'
end
