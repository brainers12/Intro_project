class CoinPriceHistory < ApplicationRecord
  belongs_to :coin

  # Validations
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :timestamp, presence: true

end

