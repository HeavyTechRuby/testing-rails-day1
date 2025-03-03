FactoryBot.define do
  factory :episode do
    podcast { create(:podcast) }
    title { "Episode Title" }
    status { "published" }
    created_at { DateTime.now }
    updated_at { DateTime.now }
    likes_count { 0 }
  end
end
