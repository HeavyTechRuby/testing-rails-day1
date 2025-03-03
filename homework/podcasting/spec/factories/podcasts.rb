FactoryBot.define do
  factory :podcast do
    status { 'new' }
    title { 'New title' }
    association :author, factory: :author

    trait :with_archived_status do
      status { 'archived' }
    end

    trait :with_nil_title do
      title { nil }
    end

    trait :with_empty_title do
      title { '' }
    end

    trait :without_author do
      author { nil }
    end

    trait :with_author_without_account do
      association :author, factory: :author_without_account
    end

    trait :with_blocked_author do
      association :author, factory: :author_blocked
    end
  end

  factory :podcast_archived, parent: :podcast, traits: [:with_archived_status]
end
