class OrdersController < ApplicationController
  def new
    @order = cart
  end

  def create
    @order = cart
    @order.update(order_params)
    session[:cart_id] = nil

    render :show
  end

  def show
    @order = PurchaseOrder.find(params[:id])
  end

  private

  def order_params
    params.require(:purchase_order).permit(:name, :email, address_attributes: [:street1, :street2, :city, :state, :zip_code, :country_code])
  end
end
