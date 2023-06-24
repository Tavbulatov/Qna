FactoryBot.define do
  factory :link do
    name { "MyString" }
    url { "https://google.com" }
    linkable { nil }

    trait :url_gist do
      url { "https://gist.github.com/Tavbulatov/789ad83d7cf2f60d151b915f9b34a025" }
    end
  end
end
