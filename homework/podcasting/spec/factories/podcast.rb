FactoryBot.define do
  factory :podcast do
    title { "Podcast Title" }
    author { create(:user) }
    status { :active }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
