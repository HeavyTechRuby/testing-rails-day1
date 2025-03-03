FactoryBot.define do
  factory :like do
    user { create(:user) }
    episode { create(:episode) }
  end
end
