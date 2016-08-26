class AddColumnsToProductCategories < ActiveRecord::Migration
  def change

  	add_column :product_categories , :product_id , :integer
  	add_column :product_categories , :category_id , :integer

  end
end
