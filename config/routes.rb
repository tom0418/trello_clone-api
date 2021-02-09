# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    resources :todos
  end
end
