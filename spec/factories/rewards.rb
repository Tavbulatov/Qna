FactoryBot.define do
  factory :reward do
    name { 'MyReward' }
    question { nil }

    after(:build) do |reward|
      reward.image.attach(io: File.open("#{Rails.root}/app/assets/images/test_image.png"), filename: 'test_image.png',
                          content_type: 'image/png')
    end
  end
end
