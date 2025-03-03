FactoryBot.define do
  factory :play_stat do
    association :episode, factory: :episode_with_podcast
    association :user, factory: :user
    position { 0 }
    is_finished { false }
  end
end
