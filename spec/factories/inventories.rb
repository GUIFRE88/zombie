# spec/factories/inventories.rb

FactoryBot.define do
  factory :inventory do
    item { ['água', 'comida', 'medicamento', 'munição'].sample }
    point { rand(1..4) }
    user

    quantity { rand(1..10) }

    trait :deleted do
      deleted_at { Time.now }
    end
  end
end
