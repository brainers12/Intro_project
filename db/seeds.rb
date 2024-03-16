# db/seeds.rb
require 'httparty'

# Define API client
class CoinRankingAPI
  include HTTParty
  base_uri 'https://api.coinranking.com/v2'

  def initialize(api_key)
    @headers = { 'x-access-token' => api_key }
  end

  def list_of_coins
    self.class.get('/coins', headers: @headers)
  end

  def coin_details(coin_id)
    self.class.get("/coin/#{coin_id}", headers: @headers)
  end

  def coin_price_history(coin_id)
    self.class.get("/coin/#{coin_id}/history", headers: @headers)
  end

  # Add any other endpoint calls if necessary
end

# Initialize API client
api_client = CoinRankingAPI.new('coinranking0b8a6f226562eb739cb10adc5fb71dab2f163d01d07bf133')

# Fetch and seed coins
coins_response = api_client.list_of_coins
if coins_response.success?
  coins_response.parsed_response['data']['coins'].each do |coin_data|
    coin = Coin.find_or_create_by!(
      name: coin_data['name'],
      symbol: coin_data['symbol']
    )

    # Fetch and seed coin details
    details_response = api_client.coin_details(coin_data['uuid'])
    if details_response.success?
      detail_data = details_response.parsed_response['data']['coin']
      CoinDetail.find_or_create_by!(
        coin: coin,
        price: detail_data['price'].to_f,
        market_cap: detail_data['marketCap'].to_f,
        circulating_supply: detail_data['circulatingSupply'].to_f,
        description: detail_data['description']
      )
    end

    # Fetch and seed coin price history
    history_response = api_client.coin_price_history(coin_data['uuid'])
    if history_response.success?
      history_data = history_response.parsed_response['data']['history']
      history_data.each do |history|
        CoinPriceHistory.find_or_create_by!(
          coin: coin,
          price: history['price'].to_f,
          timestamp: Time.at(history['timestamp'] / 1000) # assuming the timestamp is in milliseconds
        )
      end
    end
  end
end

puts 'Seeding complete.'
