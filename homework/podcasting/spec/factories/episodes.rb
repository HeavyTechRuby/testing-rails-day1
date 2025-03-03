FactoryBot.define do
  factory :episode do
    title { 'Episode One' }

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
