FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123abc' }
  end
end
