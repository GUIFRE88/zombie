FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    age { 30 }
    gender { 'M' }
    latitude { 40.7128 }
    longitude { -74.006 }
    trait :infected do
      deleted_at { Time.now }
    end
  end
end

