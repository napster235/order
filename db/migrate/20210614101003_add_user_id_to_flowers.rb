class AddUserIdToFlowers < ActiveRecord::Migration[6.1]
  def change
    add_column :flowers, :user_id, :integer
  end
end
