FactoryBot.define do
  factory :comment do
    comment { "MyComment" }
    author factory: :user
    commentable { nil }
  end
end
