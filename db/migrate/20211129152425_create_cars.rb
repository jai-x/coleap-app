# frozen_string_literal: true

class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :model_id
      t.string :make
      t.string :model
      t.integer :range_num
      t.string :range_unit
      t.string :colors
      t.decimal :price_num
      t.string :price_currency
      t.string :photo_url

      t.timestamps
    end
    add_index :cars, :model_id
    add_index :cars, :make
  end
end
