class Order < ActiveRecord::Base

	enum status: { In_Progress: 0,  Placed: 1, Shipped: 2, Cancelled: 3 }
	belongs_to :user
	has_one :order_detail

end
