class HomeController < ApplicationController


  def index
    @banner = Banner.all
    @categories = Category.where( parent_id: nil)
    @products = Product.per_page_kaminari(params[:page]).per(3)
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
  end


  def addtocart
    session[:product_ids] ||= {}
    product_ids = []
    product_ids = session[:product_ids].keys
    @cart = product_ids.count

    product_ids = product_ids.flatten.reject{|r| r == ""}
    if product_ids.include?(params[:product_id])
      session[:product_ids][params[:product_id]] = ((session[:product_ids][params[:product_id]].to_i) + params[:product_quantity].to_i).to_s
    else
      @cartvalue = {}
      @productid = params[:product_id]
      @cartvalue[@productid.to_s] = params[:product_quantity].to_s
      session[:product_ids].merge!(@cartvalue)
    end

    @cartproducts = Product.find(product_ids) if product_ids.present?

  end

end