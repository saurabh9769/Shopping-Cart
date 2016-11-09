class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_admin!, only: [:index]
  after_action :coupon_used

  def checkout
    @billing_addresses = @shipping_addresses = current_user.user_addresses
    @cart_products = []
    get_products_quantity_show_page
    cart_quantity = product_show_get_quantity
    orders_find_product_from_session_ids
    cart_products(cart_quantity)
  end

  def show
    @address = current_user.user_addresses
    redirect_to orders_checkout_orders_path
  end

  def destroy
    @address = UserAddress.find(params[:id])
    @address.destroy
    redirect_to orders_checkout_orders_path
  end

  def show_cart
    @cart_products = []
    get_products_quantity_show_page
    cart_quantity = product_show_get_quantity
    orders_find_product_from_session_ids
    cart_products(cart_quantity)
  end

  def redeem_coupon
    @billing_addresses = @shipping_addresses = current_user.user_addresses
    @cart_products = []
    orders_find_product_from_session_ids
    redeem_coupon_quantity
    @code = Coupon.where(code: params[:coupon_code]).first
  end

  def coupon_used
    if @code.present?
      Coupon.where(id: @code.id).each do |coupon_used|
        CouponsUsed.create(coupon_id: coupon_used.id, user_id: current_user.id)
      end
    end
  end

  def remove_from_cart
    @addresses = current_user.user_addresses
    session[:product_ids] ||= []
    session[:product_ids].delete(params[:product_id])
    session[:product_ids] = session[:product_ids].flatten.reject{|r| r == ""}
    @cart_products = []
    orders_find_product_from_session_ids
    @cart_products_show = {params[:id] => { :quantity => params[:quantity] }}
    remove_from_cart_quantity
  end

  def add_quantity
    @addresses = current_user.user_addresses
    @cart_products = []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
    orders_find_product_from_session_ids
    quantity
  end

  def remove_quantity
    @addresses = current_user.user_addresses
    @cart_products = []
    remove_element = [params[:product_id].to_s]
    remove_element.each do |del|
      session[:product_ids].delete_at(session[:product_ids].index(del)) if params[:product_quantity] > "1"
    end
    orders_find_product_from_session_ids
    quantity
  end

  def proceed_to_payment
    @billing_address = UserAddress.find(params[:billing_address_id])
    @shipping_address = UserAddress.find(params[:shipping_address_id])
    @cart_products = []
    get_products_quantity_show_page
    orders_find_product_from_session_ids
    cart_quantity = product_show_get_quantity
    cart_products(cart_quantity)
    if @code.present?
      @order = Order.create(coupon_id: @code.id, user_id: current_user.id, billing_address_id: params[:billing_address_id], shipping_address_id: params[:shipping_address_id], status: 0)
    else
      @order = Order.create(user_id: current_user.id, billing_address_id: params[:billing_address_id], shipping_address_id: params[:shipping_address_id], status: 0)
      @products_cart.each do |product|
        OrderDetail.create(user_id: current_user.id, order_id: @order.id, product_id: product.id, quantity: session[:product_ids].count(product.id.to_s))
      end
    end
  end

  def my_orders
    @orders = Order.where(user_id: current_user.id)
  end

  def track_package
    @order = Order.find(params[:order_id])
  end

  def index

  end

  private

  def orders_find_product_from_session_ids
    @products_cart = Product.find(session[:product_ids]) if session[:product_ids].present?
  end

  def cart_products(cart_quantity)
    if @products_cart.present?
      @products_cart.each do |product|
        if session[:product_ids].include?(product.id.to_s)
          if @cart_products_show.present? && @cart_products_show.first.keys[0] == product.id.to_s
            @quantity = cart_quantity
          else
            @quantity = cart_product_quantity(product, cart_quantity)
          end
          @quantity = session[:product_ids].count(product.id.to_s)
          @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
        end
      end
    end
  end

  def cart_product_quantity(product, cart_quantity)
    session[:product_ids].count(product.id.to_s) + cart_quantity.to_i
  end

  def redeem_coupon_quantity
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        @quantity = session[:product_ids].count(product.id.to_s)
      end
      @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
    end
  end

  def remove_from_cart_quantity
    if session[:product_ids].present?
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
    end
  end

  def quantity
    @products_cart.each do |product|
      if session[:product_ids].include?(product.id.to_s)
        @quantity = session[:product_ids].count(product.id.to_s)
        @cart_products << {product.id => { :quantity => @quantity , :price => product.price }}
      end
    end
  end

  def get_products_quantity_show_page
    @cart_products_show = []
    session[:product_ids] ||= []
    product_show_quantity = Array.new(params[:quantity].to_i,params[:id]) if params[:quantity].present?
    session[:product_ids] << product_show_quantity if product_show_quantity.present?
    session[:product_ids] = session[:product_ids].flatten! if product_show_quantity.present?
    @cart_products_show << {params[:id] => { :quantity => product_show_quantity.count.to_s }} if product_show_quantity.present?
  end

  def product_show_get_quantity
    @cart_products_show.first.fetch(params[:id]).fetch(:quantity) if @cart_products_show.present?
  end
end