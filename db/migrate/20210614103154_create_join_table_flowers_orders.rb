class CreateJoinTableFlowersOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :flowers_orders, :id => false do |t|
      t.integer :flower_id
      t.integer :order_id
    end
  end
end
