class Order < ApplicationRecord
  validates :order_number, uniqueness: true, presence: true, length: { minimum: 6 }
  validates :status, presence: true
  validates :flowers, presence: true
  belongs_to :user
  has_and_belongs_to_many :flowers

  enum status: { delivered: "delivered", pending: "pending" }
end
