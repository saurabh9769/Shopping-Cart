class AddColumnToProductImages < ActiveRecord::Migration
  def change

  	add_column :product_images , :product_id , :integer, references: :products
  end
end
