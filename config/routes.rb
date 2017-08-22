Rails.application.routes.draw do
  namespace :api do
    resources :users, except: [:new, :edit]

    resourse :profile, only: [:show, :create, :update] do
      resourse :avatar, only: [:update]
    end
  end
end