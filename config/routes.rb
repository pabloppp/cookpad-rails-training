require "monban/constraints/signed_in"
require "monban/constraints/signed_out"
require "resque/server"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedOut.new do
    root to: "homes#show"
  end
  constraints Monban::Constraints::SignedIn.new do
    root to: "dashboards#show"
  end

  constraints ->(_request) { Rails.env.development? } do
    mount Resque::Server, at: "/jobs"
  end

  resource :session, only: %i(new create destroy)
  resources :users, only: %i(new create show) do
    member do
      post "follow" => "follows#create"
      post "unfollow" => "follows#destroy"
    end
  end

  resources :recipes, only: %i(show) do
    resources :comments, only: %i(create)
    member do
      post "like" => "likes#create"
      post "unlike" => "likes#destroy"

      post "bookmark" => "bookmarks#create"
      post "unbookmark" => "bookmarks#destroy"
    end
  end

  namespace :my do
    resources :comments, only: %i(destroy)
    resources :recipes, only: %i(new create edit destroy update)
  end

  resource :search, only: %i(show)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
