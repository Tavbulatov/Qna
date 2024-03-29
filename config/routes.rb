# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  root to: 'questions#index'

  get '/search', to: 'search#search'

  concern :votable do
    resources :votes, only: %i[create destroy], shallow: true
  end

  concern :commentable do
    resources :comments, only: %i[create destroy], shallow: true
  end

  resources :attachments, only: :destroy
  resources :rewards, only: %i[show index]
  resources :links, only: :destroy

  resources :questions, concerns: %i[votable commentable],
                        defaults: { votable: 'Question', commentable: 'Question' } do
    resources :answers, shallow: true, only: %i[create update destroy],
                        concerns: %i[votable commentable],
                        defaults: { votable: 'Answer', commentable: 'Answer' } do
      patch 'best', on: :member
    end
  end

  resources :subscriptions, only: %i[] do
    member do
      post 'subscribe'
      delete 'unsubscribe'
    end
  end

  resources :authorizations, only: %i[new create] do
    get 'confirmation/:confirmation_token', action: 'confirmation', as: :confirmation
  end

  namespace :api do
    namespace :v1 do
      resources :profiles, only: %i[] do
        collection do
          get 'me'
          get 'all'
        end
      end

      resources :questions, except: :new do
        resources :answers, except: %i[new edit], shallow: true
      end
    end
  end

  mount ActionCable.server => '/cable'

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
