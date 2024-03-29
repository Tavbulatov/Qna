# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github vkontakte]

  has_many :questions, foreign_key: :author_id, dependent: :destroy
  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :authorizations, dependent: :destroy
  has_many :rewards

  has_many :subscriptions, foreign_key: 'subscribed_user_id', dependent: :destroy
  has_many :subscribed_questions, through: :subscriptions

  validates :last_name, :first_name, presence: true

  def admin?
    admin
  end

  def self.find_for_oauth(auth)
    FindForOauth.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid.to_s,
                          confirmation_token: Devise.friendly_token)
  end
end
