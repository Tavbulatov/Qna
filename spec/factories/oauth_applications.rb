# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { 'Test' }
    redirect_uri { 'https://localhost:3000/' }
    uid { '12345678' }
    secret { '876543212' }
  end
end
