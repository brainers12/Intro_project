class CoinDetail < ApplicationRecord
  belongs_to :coin

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :market_cap, numericality: { greater_than_or_equal_to: 0 }
  validates :circulating_supply, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :coin_id, uniqueness: true
end

#COin details