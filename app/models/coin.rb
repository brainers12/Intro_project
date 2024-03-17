class Coin < ApplicationRecord
    has_one :coin_detail

    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :symbol, presence: true, uniqueness: { case_sensitive: false }


end
