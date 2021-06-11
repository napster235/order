FactoryBot.define do
  factory :flower do
    name { ["Rose", "Daisy", "Orchid", "Tulip", "Jasmine"].sample }
    price { Faker::Number.number(digits: 2) }
  end
end
