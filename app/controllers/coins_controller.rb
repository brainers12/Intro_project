class CoinsController < ApplicationController
  #def index
    #@coins = Coin.includes(:coin_detail).page(params[:page]).per(10)
  #end

# app/controllers/coins_controller.rb
def index
  if params[:search].present?
    coin = Coin.find_by('lower(name) = ?', params[:search].downcase)
    if coin
      redirect_to coin_path(coin) and return
    else
      flash.now[:alert] = "Coin not found"
    end
  end

  @coins = Coin.includes(:coin_detail).order(:name).paginate(page: params[:page], per_page: 10)
end

  

  def show
    #@coin = Coin.includes(:coin_price_histories).find(params[:id])
    @coin = Coin.find(params[:id])
    # This line ensures you have price histories available in your view
    #@coin_price_histories = @coin.coin_price_histories
    #@price_histories = @coin.coin_price_histories.order(timestamp: :desc)
    
  end


  def about
    # You can set up instance variables here if you need to share data with the view
  end


  def menu
    if params[:sort] == 'highest'
      @coins = Coin.joins(:coin_detail).order('coin_details.price DESC')
    elsif params[:sort] == 'lowest'
      @coins = Coin.joins(:coin_detail).order('coin_details.price ASC')
    else
      @coins = Coin.joins(:coin_detail)
    end
  end
  
end
