namespace :populate do
  desc "populate order list"
  task orders: :environment do

    puts "Populating orders table ..."
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

  desc "populate flower list"
  task flowers: :environment do

    puts "Populating flowers table ..."
    [
      { name: "Lily", price: "10", user_id: 1 },
      { name: "Water Lily", price: "11", user_id: 1 },
      { name: "Rose", price: "12", user_id: 1 },
      { name: "Blossom", price: "13", user_id: 1 },
      { name: "Orchid", price: "14", user_id: 1 },
      { name: "Cactus", price: "15", user_id: 1 },
      { name: "Daisy", price: "16", user_id: 1 },
      { name: "Sun Flower", price: "17", user_id: 1 },
      { name: "Dahlia", price: "18", user_id: 1 }
    ].each do |attributes|
      Flower.find_or_create_by(attributes)
    end
    puts "Finised!"
  end
end
