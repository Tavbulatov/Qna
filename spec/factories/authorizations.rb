FactoryBot.define do
  factory :authorization do
    provider { "vkontakte" }
    uid { "123123" }
    confirmation_token { nil }
    confirmed_at { nil }
    user { nil }
  end
end
