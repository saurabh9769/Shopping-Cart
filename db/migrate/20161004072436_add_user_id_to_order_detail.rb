class AddUserIdToOrderDetail < ActiveRecord::Migration
  def change
  	add_column :order_details, :user_id, :integer
  end
end
