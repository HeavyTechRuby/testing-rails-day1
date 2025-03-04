FactoryBot.define do
  factory :subscription do
    user { create(:user) }
    podcast { create(:podcast) }
  end
end
