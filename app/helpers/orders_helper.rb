module OrdersHelper

	def find_products(cart)
		Product.find(cart.keys[0])
	end

	def calculate_total_of_products(cart, product)
		product.price * cart.fetch(product.id).fetch(:quantity).to_f
	end

	def calculate_total_price(total)
		total.inject(0){|sum,x| sum + x }
	end

	def calculate_discounted_value(totalvalue)
		totalvalue - (@code.percent_off * totalvalue/100) if @code.present?
	end

end
