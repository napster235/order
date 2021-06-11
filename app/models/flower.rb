class Flower < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }
  validates :price, numericality: { only_integer: true }, presence: true

  ransacker :price do
    Arel.sql("CAST(price AS TEXT)")
  end
end
