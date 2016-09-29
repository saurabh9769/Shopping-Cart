class OrdersController < ApplicationController
  before_action :authenticate_user!
  after_action :coupon_used

  def checkout
    @billing_addresses = current_user.user_addresses.all
    @shipping_addresses = current_user.user_addresses.all
    @cart_products = []
    add = [params[:id]] * params[:quantity].to_i if params[:quantity].present?
    session[:product_ids] << add if add.present?
    session[:product_ids] = session[:product_ids].flatten if session[:product_ids].present?
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

  def show
    # binding.pry
    @address = current_user.user_addresses.all
    redirect_to order_orders_checkout_path
  end

  def destroy
    @address = UserAddress.find(params[:id])
    @address.destroy
    redirect_to order_orders_checkout_path
  end

  def show_cart
    @cart_products = []
    add = [params[:id]] * params[:quantity].to_i if params[:quantity].present?
    session[:product_ids] << add if add.present?
    session[:product_ids] = session[:product_ids].flatten if session[:product_ids].present?
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
    @billing_addresses = current_user.user_addresses.all
    @shipping_addresses = current_user.user_addresses.all
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
        CouponsUsed.create(coupon_id: coupon_used.id, user_id: current_user.id)
      end
    end
  end

  def remove_from_cart
    @addresses = current_user.user_addresses.all
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

  def quantity_up
    @addresses = current_user.user_addresses.all
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

  def quantity_down
    @addresses = current_user.user_addresses.all
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

  def proceed_to_payment
    @billing_address = UserAddress.find(params[:billing_address_id])
    @shipping_address = UserAddress.find(params[:shipping_address_id])
    @code = Coupon.where(code: params[:coupon_code]).first
    if @code.present?
      Order.create(coupon_id: @code.id, user_id: current_user.id, billing_address_id: params[:billing_address_id], shipping_address_id: params[:shipping_address_id])
    else
      Order.create(user_id: current_user.id, billing_address_id: params[:billing_address_id], shipping_address_id: params[:shipping_address_id])
    end
    @cart_products = []
    add = [params[:id]] * params[:quantity].to_i if params[:quantity].present?
    session[:product_ids] << add if add.present?
    session[:product_ids] = session[:product_ids].flatten if session[:product_ids].present?
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
  def make_payment
    @amount = params[:totalvalue]
    #This will create a charge with stripe for $10
    #Save this charge in your DB for future reference
    charge = Stripe::Charge.create(
      :amount => @amount * 100,
      :currency => "inr",
      :source => params[:stripeToken],
      :description => "Test Charge"
    )
    flash[:notice] = "Successfully created a charge"
    redirect_to '/subscription'
  end

end
