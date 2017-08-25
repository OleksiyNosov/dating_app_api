Rails.application.routes.draw do
  namespace :api do
    resource :session, only: [:create, :destroy]

    resource :profile, only: [:show, :create, :update] do
      match 'avatar', to: 'avatars#update', via: :post
    end

    resources :places, only: [:index, :show, :create, :update] do
      resource :place_user, only: [:show, :create, :update]
    end
  end
end