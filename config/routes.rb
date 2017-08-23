Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:show, :create, :update] do
      resource :avatar, only: [:update]
    end
  end
end