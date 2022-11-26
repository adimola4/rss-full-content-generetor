# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      resources :rss do
        post "ready", to: "rss#ready"
      end
    end
  end
  resources :rss do
    post "ready", to: "rss#ready"
  end
end
