class CreateCouponsUseds < ActiveRecord::Migration
  def change
    create_table :coupons_useds do |t|

    	t.integer :user_id
    	t.integer :order_id
    	t.integer :coupon_id

      t.timestamps null: false
    end
  end
end
