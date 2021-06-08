namespace :orders do
  desc "populate order list"
  task populate: :environment do

    puts "Populating orders ..."
    [
      { order_number: "Order_123", status: "pending", user_id: 1 },
      { order_number: "Order_1234", status: "delivered", user_id: 1 },
      { order_number: "Order_1235", status: "delivered", user_id: 1 },
      { order_number: "Order_1243", status: "pending", user_id: 1 },
      { order_number: "Order_1435", status: "pending", user_id: 1 },
      { order_number: "Order_12323", status: "delivered", user_id: 1 },
      { order_number: "Order_123789", status: "pending", user_id: 1 },
      { order_number: "Order_123009", status: "pending", user_id: 1 },
      { order_number: "Order_1098", status: "delivered", user_id: 1 }
    ].each do |attributes|
      Order.find_or_create_by(attributes)
    end
    puts "Finished!"
  end
end