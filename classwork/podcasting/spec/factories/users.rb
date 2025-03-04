FactoryBot.define do
  factory :user do
    trait :blocked do
      status { "blocked" }
    end
  end
end
