class CoinsController < ApplicationController
  def index
    @coins = Coin.includes(:coin_detail).page(params[:page]).per(10)
  end

  def show
    @coin = Coin.find(params[:id])
    # This line ensures you have price histories available in your view
    @coin_price_histories = @coin.coin_price_histories
    
  end
end
