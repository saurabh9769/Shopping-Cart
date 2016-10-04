class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
    	t.integer :order_id
    	t.integer :product_id
    	t.integer :quantity
    	t.float :amount

      t.timestamps null: false
    end
  end
end
