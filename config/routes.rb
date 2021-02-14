# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :accounts, path: 'api/auth', controllers: {
    confirmations: 'api/auth/confirmations',
    passwords: 'api/auth/passwords',
    registrations: 'api/auth/registrations',
    sessions: 'api/auth/sessions'
  }

  namespace :api do
    resources :todos
  end
end
