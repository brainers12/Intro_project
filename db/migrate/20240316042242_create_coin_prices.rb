class CreateCoinPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :coin_prices do |t|
      t.references :coin, null: false, foreign_key: true
      t.string :currency
      t.decimal :price
      t.datetime :timestamp

      t.timestamps
    end
  end
end
