class Order < ApplicationRecord
  validates :order_number, uniqueness: true, presence: true, length: { minimum: 6 }
  validates :user_id, presence: true
  validates :status, presence: true
  belongs_to :user

  enum status: { delivered: "delivered", pending: "pending" }
end
