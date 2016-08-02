class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :mini_description
      t.integer :price
      t.integer :discount

      t.timestamps
    end
  end
end
