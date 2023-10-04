FactoryBot.define do
  factory :authorization do
    provider { "vkontakte" }
    uid { "123123" }
    confirmation_token { Devise.friendly_token }
    confirmed_at { nil }
    user { nil }
  end
end
