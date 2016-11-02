class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authenticate_admin!, only: [:index]
  after_action :coupon_used

  def checkout
    @billing_addresses = current_user.user_addresses.all
    @shipping_addresses = current_user.user_addresses.all
    @cart_products = []
    session[:product_ids] ||= []
    product_show_quantity = Array.new(params[:quantity].to_i,params[:id]) if params[:quantity].present?
    session[:product_ids] << product_show_quantity.flatten if product_show_quantity.present?
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
  end

  def show
    @address = current_user.user_addresses.all
    redirect_to orders_checkout_orders_path
  end

  def destroy
    @address = UserAddress.find(params[:id])
    @address.destroy
    redirect_to orders_checkout_orders_path
  end

  def show_cart
    @cart_products = []
    session[:product_ids] ||= []
    product_show_quantity = Array.new(params[:quantity].to_i,params[:id]) if params[:quantity].present?
    session[:product_ids] << product_show_quantity if product_show_quantity.present?
    session[:product_ids] = session[:product_ids].flatten! if product_show_quantity.present?
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
  end

  def redeem_coupon
    @billing_addresses = current_user.user_addresses.all
    @shipping_addresses = current_user.user_addresses.all
    @cart_products = []
    @products_cart = Product.find(session[:product_ids])
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
  end

  def quantity_up
    @addresses = current_user.user_addresses.all
    @cart_products = []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
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
  end

  def proceed_to_payment
    @billing_address = UserAddress.find(params[:billing_address_id])
    @shipping_address = UserAddress.find(params[:shipping_address_id])
    @cart_products = []
    session[:product_ids] ||= []
    product_show_quantity = Array.new(params[:quantity].to_i,params[:id]) if params[:quantity].present?
    session[:product_ids] << product_show_quantity.flatten if product_show_quantity.present?
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
    @code = Coupon.where(code: params[:coupon_code]).first
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
    # Users Registered
    @customers = User.all
    @chart_customer = []
    customer_data = []
    @customer_count = []
    @customers.each do |customer|
      @month = customer.created_at.strftime("%b")
      if @month == "Jan"
        customer_data = customer.id
      elsif @month == "Feb"
        customer_data = customer.id
      elsif @month == "Mar"
        customer_data = customer.id
      elsif @month == "Apr"
        customer_data = customer.id
      elsif @month == "May"
        customer_data = customer.id
      elsif @month == "Jun"
        customer_data = customer.id
      elsif @month == "Jul"
        customer_data = customer.id
      elsif @month == "Aug"
        customer_data = customer.id
      elsif @month == "Sep"
        customer_data = customer.id
      elsif @month == "Oct"
        customer_data = customer.id
      elsif @month == "Nov"
        customer_data = customer.id
      elsif @month == "Dec"
        customer_data = customer.id
      end
      @chart_customer << { @month => customer_data }
    end

    jan_customer = []
    feb_customer = []
    mar_customer = []
    apr_customer = []
    may_customer = []
    jun_customer = []
    jul_customer = []
    aug_customer = []
    sep_customer = []
    oct_customer = []
    nov_customer = []
    dec_customer = []
    @chart_customer.each do |customer|
      if customer.include?("Jan")
        jan_customer << customer.keys.count("Jan")
        @jan_customer = jan_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Feb")
        feb_customer << customer.keys.count("Feb")
        @feb_customer = feb_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Mar")
        mar_customer << customer.keys.count("Mar")
        @mar_customer = mar_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Apr")
        apr_customer << customer.keys.count("Apr")
        @apr_customer = apr_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("May")
        may_customer << customer.keys.count("May")
        @may_customer = may_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Jun")
        jun_customer << customer.keys.count("Jun")
        @jun_customer = jun_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Jul")
        jul_customer << customer.keys.count("Jul")
        @jul_customer = jul_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Aug")
        aug_customer << customer.keys.count("Aug")
        @aug_customer = aug_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Sep")
        sep_customer << customer.keys.count("Sep")
        @sep_customer = sep_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Oct")
        oct_customer << customer.keys.count("Oct")
        @oct_customer = oct_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Nov")
        nov_customer << customer.keys.count("Nov")
        @nov_customer = nov_customer.inject(0){|sum,x| sum + x }
      elsif customer.include?("Dec")
        dec_customer << customer.keys.count("Dec")
        @dec_customer = dec_customer.inject(0){|sum,x| sum + x }
      end
    end

    # Coupons Used
    coupons_used = CouponsUsed.all
    coupon_count = []
    @chart_coupon_used = []
    coupons_used.each do |coupon|
      @month = coupon.created_at.strftime("%b")
      if @month == "Jan"
        coupon_used_count = coupon.id
      elsif @month == "Feb"
        coupon_used_count = coupon.id
      elsif @month == "Mar"
        coupon_used_count = coupon.id
      elsif @month == "Apr"
        coupon_used_count = coupon.id
      elsif @month == "May"
        coupon_used_count = coupon.id
      elsif @month == "Jun"
        coupon_used_count = coupon.id
      elsif @month == "Jul"
        coupon_used_count = coupon.id
      elsif @month == "Aug"
        coupon_used_count = coupon.id
      elsif @month == "Sep"
        coupon_used_count = coupon.id
      elsif @month == "Oct"
        coupon_used_count = coupon.id
      elsif @month == "Nov"
        coupon_used_count = coupon.id
      elsif @month == "Dec"
        coupon_used_count = coupon.id
      end
      @chart_coupon_used << { @month => coupon_used_count }
    end

    jan_coupon = []
    feb_coupon = []
    mar_coupon = []
    apr_coupon = []
    may_coupon = []
    jun_coupon = []
    jul_coupon = []
    aug_coupon = []
    sep_coupon = []
    oct_coupon = []
    nov_coupon = []
    dec_coupon = []
    @chart_coupon_used.each do |coupon_used|
      if coupon_used.include?("Jan")
        jan_coupon << coupon_used.keys.count("Jan")
        @jan_coupon = jan_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Feb")
        feb_coupon << coupon_used.keys.count("Feb")
        @feb_coupon = feb_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Mar")
        mar_coupon << coupon_used.keys.count("Mar")
        @mar_coupon = mar_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Apr")
        apr_coupon << coupon_used.keys.count("Apr")
        @apr_coupon = apr_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("May")
        may_coupon << coupon_used.keys.count("May")
        @may_coupon = may_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Jun")
        jun_coupon << coupon_used.keys.count("Jun")
        @jun_coupon = jun_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Jul")
        jul_coupon << coupon_used.keys.count("Jul")
        @jul_coupon = jul_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Aug")
        aug_coupon << coupon_used.keys.count("Aug")
        @aug_coupon = aug_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Sep")
        sep_coupon << coupon_used.keys.count("Sep")
        @sep_coupon = sep_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Oct")
        oct_coupon << coupon_used.keys.count("Oct")
        @oct_coupon = oct_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Nov")
        nov_coupon << coupon_used.keys.count("Nov")
        @nov_coupon = nov_coupon.inject(0){|sum,x| sum + x }
      elsif coupon_used.include?("Dec")
        dec_coupon << coupon_used.keys.count("Dec")
        @dec_coupon = dec_coupon.inject(0){|sum,x| sum + x }
      end
    end
  end
end