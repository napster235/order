class Order < ApplicationRecord
  validates :order_number, uniqueness: true, presence: true
  validates :user_id, presence: true
  validates :status, presence: true
  belongs_to :user

  enum status: { delivered: 0, pending: 1 }
end
