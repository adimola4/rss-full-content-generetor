# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      get "/rss", to: "rss#index"
      post "/rss", to: "rss#create"
      get "/rss/:id", to: "rss#show"
      patch "/rss/:id", to: "rss#update"
      delete "/rss/:id", to: "rss#destroy"
      post "/rss/ready/", to: "rss#ready"
    end
  end
end
