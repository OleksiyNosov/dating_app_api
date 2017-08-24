Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:show, :create, :update] do
      match 'avatar', to: 'avatars#update', via: :post
    end
  end
end