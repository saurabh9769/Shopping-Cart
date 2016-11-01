class UserWishListController < ApplicationController

	before_action :authenticate_user!

	def show_wish_list
		$wishlist ||= []
		if params[:product_id].present?
			if $wishlist.include?(params[:product_id])
				flash[:notice] = "Product Already in WishList"
			else
				$wishlist << params[:product_id]
				UserWishList.create(user_id: current_user.id, product_id: params[:product_id])
				flash[:success] = "Added To WishList"
			end
		end
	end

	def remove_from_wish_list
		UserWishList.delete_all(product_id: params[:product_id])
		$wishlist.delete(params[:product_id])
	end

	def add_to_cart
		session[:product_ids] ||= []
    session[:product_ids] << params[:product_id] if params[:product_id].present?
    UserWishList.delete_all(product_id: params[:product_id])
  end

end
