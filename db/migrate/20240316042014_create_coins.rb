class CreateCoins < ActiveRecord::Migration[7.1]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.text :description

      t.timestamps
    end
  end
end
