class Order < ActiveRecord::Base

	enum status: { Accepted: 0, In_Progress: 1, Shipped: 2, Delivered: 3 , Completed: 4, Cancelled: 5 }
	belongs_to :user
	has_many :order_details
	has_many :products, through: :order_details

end
