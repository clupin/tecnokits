class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :name
      t.text :description
      t.references :product, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
