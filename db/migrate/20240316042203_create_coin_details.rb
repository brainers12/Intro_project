class CreateCoinDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :coin_details do |t|
      t.references :coin, null: false, foreign_key: true
      t.decimal :price
      t.decimal :market_cap
      t.integer :circulating_supply
      t.text :description

      t.timestamps
    end
  end
end
