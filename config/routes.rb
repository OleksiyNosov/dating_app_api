Rails.application.routes.draw do
  namespace :api do
    resource :profile, only: [:show, :create, :update] do
      resource :avatar, only: [:update]
    end
  end
end