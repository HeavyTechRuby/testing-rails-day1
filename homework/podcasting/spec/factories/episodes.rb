FactoryBot.define do
  factory :episode do
    title { 'Episode One' }

    trait :with_podcast do
      association :podcast, factory: :podcast
    end

    trait :with_archived_podcast do
      association :podcast, factory: :podcast_archived
    end

    trait :with_status_published do
      status { 'published' }
    end

    trait :with_status_draft do
      status { 'draft' }
    end

    trait :with_status_unpublished do
      status { 'unpublished' }
    end
  end
end
