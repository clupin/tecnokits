class CreateProductAttachments < ActiveRecord::Migration
  def change
    create_table :product_attachments do |t|
      t.integer :product_id
      t.string :image
      t.boolean :principal

      t.timestamps
    end
  end
end
