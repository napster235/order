FactoryBot.define do
  factory :order do
    order_number { "Order_#{Faker::Number.number(digits: 6)}".to_s }
    user_id { FactoryBot.create(:user).id }
    status { ["delivered", "pending"].sample }
  end
end
