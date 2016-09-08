  class HomeController < ApplicationController


	def index
		@banner = Banner.all
		@categories = Category.where( parent_id: nil)
		@products = Product.per_page_kaminari(params[:page]).per(3)
		@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
		@cart = session[:product_ids].count if params[:product_id].present?
	end


	def add_to_cart
		session[:product_ids] ||= []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
    @cart = session[:product_ids].count
    @products_cart = Product.find(session[:product_ids])
    if session[:product_ids].include?(params[:product_id])
      @quantity = session[:product_ids].count(params[:product_id])
		end
  end

  def show_cart

    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
    @cart = session[:product_ids].count
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        @quantity = session[:product_ids].count(product.id.to_s)
      end
      @cart_products << {product.id => { :quantity => @quantity , :price => (product.price * product.quantity.to_f) }}
    end
  end

	def remove_from_cart
		session[:product_ids] ||= []
		session[:product_ids].delete(params[:product_id])
    @cart = session[:product_ids].count
    product_ids = session[:product_ids].flatten.reject{|r| r == ""}
    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
    @cart = session[:product_ids].count
    @products_cart.each do |product|
    if session[:product_ids].include?(product.id.to_s)
      @quantity = session[:product_ids].count(product.id.to_s)
    end
      @cart_products << {product.id => { :quantity => @quantity , :price => (product.price * product.quantity.to_f) }}
    end
	end

end