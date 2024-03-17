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
end

# Initialize API client with your API key
api_client = CoinRankingAPI.new('coinranking0b8a6f226562eb739cb10adc5fb71dab2f163d01d07bf133') # Replace with your real API key

# Fetch and seed coins
coins_response = api_client.list_of_coins
if coins_response.success?
  coins_data = coins_response.parsed_response['data']['coins']
  
  coins_data.each do |coin_data|
    # Create or update coin
    coin = Coin.find_or_create_by!(
      name: coin_data['name'],
      symbol: coin_data['symbol']
    )

    # Fetch and seed coin details
    details_response = api_client.coin_details(coin_data['uuid'])
    if details_response.success?
      detail_data = details_response.parsed_response['data']['coin']
      
      # Find or initialize CoinDetail to update or create
      coin_detail = CoinDetail.find_or_initialize_by(coin_id: coin.id)
      coin_detail.update!(
        price: detail_data['price'].to_f,
        market_cap: detail_data['marketCap'].to_f,
        circulating_supply: detail_data['circulatingSupply'].to_s.gsub(',', '').to_i,
        description: detail_data['description']
      )
    else
      puts "Failed to fetch details for #{coin_data['name']}. Error: #{details_response['status']}"
    end
  end
  
  puts 'Seeding coins and coin details complete.'
else
  puts "Failed to fetch coins list. Error: #{coins_response['status']}"
end

