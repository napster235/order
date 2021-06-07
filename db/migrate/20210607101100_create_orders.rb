class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end
