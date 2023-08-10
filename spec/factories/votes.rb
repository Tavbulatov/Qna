FactoryBot.define do
  factory :vote do
    body { 'Up' }
    author { nil }
    votable { nil }

    trait :down do
      body { 'Down' }
    end
  end
end
