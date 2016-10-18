class UserAddressesController < ApplicationController

  def index
    @addresses = current_user.user_addresses.all
  end

  def show
    @address = current_user.user_addresses.all
  end

  def new
    @address = UserAddress.new
  end

  def create
    @address = UserAddress.create(address_params)
    @address.user_id = current_user.id
    # @address = current_user.user_addresses.create(address_params) if user_addresses.present?
    @address.save
    redirect_to orders_checkout_path(@address)
  end

  def edit
    @address = UserAddress.find(params[:id])
    @address.user_id = current_user.id
  end


  def update
    @address = UserAddress.find(params[:id])
    @address.update(address_params)
    redirect_to order_path(@address)
  end

  def destroy
    @address = UserAddress.find(params[:id])
    @address.destroy
    redirect_to orders_checkout_orders_path
  end

  private
    def address_params
      params.require(:user_address).permit(:address_1, :address_2, :city, :state, :country, :zipcode)
    end

end
