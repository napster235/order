class ChangeStatusTypeFromIntegerToString < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :status, :string
  end
end
