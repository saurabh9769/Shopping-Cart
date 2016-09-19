  class HomeController < ApplicationController

	def index
		@banner = Banner.all
		@categories = Category.where( parent_id: nil)
		@products = Product.per_page_kaminari(params[:page]).per(3)
		@products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
		@cart = session[:product_ids].count if session[:product_ids].present?
	end

	def add_to_cart
		session[:product_ids] ||= []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
    @cart = session[:product_ids].count
  end

  # def product_show_cart
  #   @cart_products = []
  #   session[:product_ids] << params[:id] if params[:id].present?
  #   @cart = session[:product_ids].count
  #   @cart_products_show = []
  #   @products_cart = Product.find(session[:product_ids])
  #   @cart = session[:product_ids].count
  #   @cart_products_show << {params[:id] => { :quantity => params[:quantity] }}
  #   @products_cart.each do |product|
  #     if session[:product_ids].include?(product.id.to_s)
  #       if @cart_products_show.first.keys[0] == product.id.to_s
  #         @quantity = @cart_products_show.first.fetch(params[:id]).fetch(:quantity).to_i
  #       else
  #         @quantity = session[:product_ids].count(product.id.to_s)
  #       end
  #       @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
  #     end
  #     binding.pry
  #   end
  #   show_cart
  #   redirect_to "/home/show_cart"
  # end

  def show_cart
    # @cart_products = []
    # @products_cart = Product.find(session[:product_ids])
    # @cart = session[:product_ids].count
    # @products_cart.each do |product|
    #   if session[:product_ids].include?(product.id.to_s)
    #     @quantity = session[:product_ids].count(product.id.to_s)
    #   end
    #   @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
    # end
    @cart_products = []
    session[:product_ids] << params[:id] if params[:id].present?
    @cart = session[:product_ids].count
    @cart_products_show = []
    @products_cart = Product.find(session[:product_ids])
    @cart = session[:product_ids].count
    @cart_products_show << {params[:id] => { :quantity => params[:quantity] }}
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        if @cart_products_show.first.keys[0] == product.id.to_s
          @quantity = @cart_products_show.first.fetch(params[:id]).fetch(:quantity).to_i
        else
          @quantity = session[:product_ids].count(product.id.to_s)
        end
        @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
      end
    end
  end

  def redeem_coupon
    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
    @cart = session[:product_ids].count
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        @quantity = session[:product_ids].count(product.id.to_s)
      end
      @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
    end
    @code = Coupon.where(code: params[:coupon_code]).first
  end

	def remove_from_cart
		session[:product_ids] ||= []
		session[:product_ids].delete(params[:product_id])
    @cart = session[:product_ids].count
    product_ids = session[:product_ids].flatten.reject{|r| r == ""}
    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
    @cart = session[:product_ids].count
    @cart_products_show = {params[:id] => { :quantity => params[:quantity] }}
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        if @cart_products_show.first[0] == product.id.to_s
          @quantity = @cart_products_show.fetch(params[:id]).fetch(:quantity).to_i
        else
          @quantity = session[:product_ids].count(product.id.to_s)
        end
      end
      @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
    end
	end

  def cart_quantity_up
    @cart_products = []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
    @cart = session[:product_ids].count
    @cart_products_show = []
    @products_cart = Product.find(session[:product_ids])
    # @cart = session[:product_ids].count
    @cart_products_show << {params[:id] => { :quantity => params[:quantity] }}
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        if @cart_products_show.first.keys[0] == product.id.to_s
          @quantity = @cart_products_show.first.fetch(params[:id]).fetch(:quantity).to_i
        else
          @quantity = session[:product_ids].count(product.id.to_s)
        end
        @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
      end
    end
  end

  def cart_quantity_down
    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
    # session[:product_ids].count(params[:product_id].to_s) - 1
    # binding.pry
    @quantity = session[:product_ids].count(params[:product_id].to_s) - 1
    @cart_products << {params[:product_id] => { :quantity => @quantity }}
    # binding.pry
    @products_cart.each do |product|
    end
    @cart = session[:product_ids].count
  end
end