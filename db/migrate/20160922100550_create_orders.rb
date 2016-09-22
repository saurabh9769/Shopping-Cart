class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

    	t.integer :user_id, references: :users
    	t.integer :billing_address_id
    	t.integer :shipping_address_id
    	t.integer :shipping_method
    	t.text :awb_no
    	t.integer :payment_gateway_id
    	t.integer :transaction_id
    	t.integer :status
    	t.float :grand_total
    	t.float :shipping_charges
    	t.integer :coupon_id

      t.timestamps null: false
    end
  end
end
