FactoryBot.define do
  factory :comment do
    body { "MyString" }
    author { nil }
    commentable { nil }
  end
end
