class CreateCoinPriceHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :coin_price_histories do |t|
      t.references :coin, null: false, foreign_key: true
      t.decimal :price
      t.datetime :timestamp

      t.timestamps
    end
  end
end
