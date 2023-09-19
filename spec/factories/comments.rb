FactoryBot.define do
  factory :comment do
    comment { "MyComment" }
    author { nil }
    commentable { nil }
  end
end
