class Product < ActiveRecord::Base

	enum status: { active: 1 ,  inactive: 0 }

	belongs_to :category
  	has_many :product_images
  	has_many :order_details
  	has_many :orders, through: :order_details
end
