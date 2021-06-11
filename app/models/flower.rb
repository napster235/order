class Flower < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { only_integer: true }, presence: true
end
