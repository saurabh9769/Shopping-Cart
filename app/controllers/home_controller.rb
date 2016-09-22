  class HomeController < ApplicationController

  after_action :coupon_used

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

  def show_cart
    @cart_products = []
    add = [params[:id]] * params[:quantity].to_i if params[:quantity].present?
    session[:product_ids] << add if add.present?
    session[:product_ids] = session[:product_ids].flatten
    @cart_products_show = []
    @cart_products_show << {params[:id] => { :quantity => add.count.to_s }} if add.present?
    @products_cart = Product.find(session[:product_ids]) if session[:product_ids].present?
    if @products_cart.present?
      @products_cart.each do |product|
        if session[:product_ids].include?(product.id.to_s)
          if @cart_products_show.present? && @cart_products_show.first.keys[0] == product.id.to_s
            @quantity = @cart_products_show.first.fetch(params[:id]).fetch(:quantity)
          else
            @quantity = session[:product_ids].count(product.id.to_s) + @cart_products_show.first.fetch(params[:id]).fetch(:quantity).to_i if @cart_products_show.present?
          end
          @quantity = session[:product_ids].count(product.id.to_s)
          @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
        end
      end
    end
    @cart = session[:product_ids].count if session[:product_ids].present?
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

  def coupon_used
    if @code.present?
      @code = Coupon.where(code: params[:coupon_code]).first
      Coupon.where(id: @code.id).each do |coupon_used|
        CouponsUsed.create(coupon_id: coupon_used.id)
      end
    end
  end

  def remove_from_cart
    session[:product_ids] ||= []
    session[:product_ids].delete(params[:product_id])
    @cart = session[:product_ids].count
    product_ids = session[:product_ids].flatten.reject{|r| r == ""}
    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
    @cart_products_show = {params[:id] => { :quantity => params[:quantity] }}
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        if @cart_products_show.first[0] == product.id.to_s
          @quantity = session[:product_ids].count(product.id.to_s)
        else
          @quantity = session[:product_ids].count(product.id.to_s)
        end
      end
      @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
    end
    @cart = session[:product_ids].count
  end

  def cart_quantity_up
    @cart_products = []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
    @cart = session[:product_ids].count
    @products_cart = Product.find(session[:product_ids])
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        @quantity = session[:product_ids].count(product.id.to_s)
        @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
      end
    end
  end

  def cart_quantity_down
    @cart_products = []
    remove_element = [params[:product_id].to_s]
    remove_element.each do |del|
      session[:product_ids].delete_at(session[:product_ids].index(del)) if params[:product_quantity] > "1"
    end
    @products_cart = Product.find(session[:product_ids])
    @products_cart.each do |product|
      @quantity = session[:product_ids].count(product.id.to_s)
      @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
    end
    @cart = session[:product_ids].count
  end
end