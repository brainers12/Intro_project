class Coin < ApplicationRecord
    has_one :coin_detail
    has_many :coin_prices
    has_many :coin_price_histories

    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :symbol, presence: true, uniqueness: { case_sensitive: false }


end
