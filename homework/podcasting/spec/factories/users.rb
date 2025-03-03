FactoryBot.define do
  factory :user, aliases: [:author, :subscriber, :no_subscriber] do
    name { "John Marston" }
    association :account, factory: :account

    trait :blocked do
      blocked { true }
    end

    trait :without_account do
      account { nil }
    end
  end

  factory :author_blocked, parent: :user, traits: [:blocked]
  factory :author_without_account, parent: :user, traits: [:without_account]
end
