Rails.application.routes.draw do
  namespace :api do
    resource :session, only: %i[create destroy]

    resource :profile, only: %i[show create update] do
      resource :avatar, only: %i[create destroy]

      resources :invites, only: %i[index show update], controller: :'profiles/invites'
    end

    resources :users, only: %i[index show] do
      resources :user_ratings, only: [:index]
    end

    resources :places, only: %i[index show create update] do
      resource :place_user, only: %i[show create update]

      resources :user_ratings, only: [:index]

      resources :events, only: [:index]
    end

    resources :events, except: %i[new edit] do
      resources :invites, only: %i[index show create], controller: :'events/invites'
    end
  end
end
