Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:show, :create, :update] do
      resource :avatar, only: [:create, :destroy]

      resources :invites, only: [:index, :show, :update], controller: :profile_invites
    end

    resources :users, only: [:index, :show] do
      resources :user_ratings, only: [:index]
    end

    resources :places, only: [:index, :show, :create, :update] do
      resource :place_user, only: [:show, :create, :update]

      resources :user_ratings, only: [:index]

      resources :events, only: [:index]
    end

    resources :events, except: [:new, :edit] do
      resources :invites, only: [:index, :show, :create], controller: :event_invites
    end
  end
end