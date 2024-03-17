class CoinPrice < ApplicationRecord
  belongs_to :coin

  # Validations
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true
  validates :timestamp, presence: true

end
#COin price