FactoryBot.define do
  factory :user do
    name { "John Doe" }
    blocked { false }
    created_at { DateTime.now }
    updated_at { DateTime.now }
  end
end
