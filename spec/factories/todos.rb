FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(5) }
  end
end
