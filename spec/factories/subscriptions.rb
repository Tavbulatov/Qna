# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    subscribed_user_id { create(:user) }
    subscribed_question_id { create(:question) }
  end
end
