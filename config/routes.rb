Rails.application.routes.draw do
  devise_for :users
  root to: 'questions#index'

  concern :votable do
    resources :votes, only: %i[create destroy], shallow: true
  end

  concern :commentable do
    resources :comments, only: %i[create destroy], shallow: true
  end

  resources :attachments, only: :destroy
  resources :rewards, only: %i[show index]
  resources :links, only: :destroy

  resources :questions, concerns: [:votable, :commentable],
                        defaults: { votable: 'Question', commentable: 'Question' } do
    resources :answers, shallow: true, only: %i[create update destroy],
                        concerns: [:votable, :commentable],
                        defaults: { votable: 'Answer', commentable: 'Answer' } do
      patch 'best', on: :member
    end
  end

  mount ActionCable.server => '/cable'
end
