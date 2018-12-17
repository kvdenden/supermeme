class OrdersController < ApplicationController
  def new
    @order = cart.dup
    @address = @order.address || Address.new
  end

  def create
    @order = cart
    @order.update(order_params)
    Printful::CreateOrder.new(@order).call

    session[:cart_id] = nil

    render :show
  end

  def show
    @order = PurchaseOrder.find(params[:id])
  end

  private

  def order_params
    params.require(:purchase_order).permit(:name, :email, address_attributes: [:street1, :street2, :city, :state, :zip_code, :state_code, :country_code])
  end
end
