class CoinsController < ApplicationController
  

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
    @coin = Coin.find(params[:id])
  end


  def about
    
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
