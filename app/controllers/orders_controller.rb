# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :noindex

  def new
    redirect_to root_url if cart.empty?

    @order = cart.dup

    @address = @order.address || Address.new

    flash[:fulfillment_errors]&.each do |err|
      @order.errors.add(:base, err)
    end

    if flash[:validate]
      @order.validate
      @address.validate
    end
  end

  def create
    order = cart

    if order.update(order_params)
      ok_for_fulfiller = Fulfillment::ValidateOrder.new(order).call
      if ok_for_fulfiller
        redirect_to action: :pay
      else
        flash[:fulfillment_errors] = order.errors[:base]
        redirect_to action: :new
      end
    else
      order.save(validate: false)
      flash[:validate] = true
      redirect_to action: :new
    end
  end

  def pay
    @order = cart
  end

  def charge
    @order = PurchaseOrder.find(params[:order_id])

    # create stripe charge
    Stripe::CreateCharge.new(@order).call(params[:stripeToken])

    @order.update(status: 'paid')

    # send order to fulfiller
    create_order = Fulfillment::CreateOrder.new(@order)
    fulfillment_id = create_order.call(confirm: Rails.configuration.fulfillment[:confirm_order])
    @order.update(fulfiller: create_order.fulfiller, fulfillment_id: fulfillment_id)

    # clear cart
    session[:cart_id] = nil

    # send order confirmation email
    OrderMailer.with(order: @order).order_confirmation.deliver_later

    render :show
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to checkout_pay_path
  end

  def show
    @order = PurchaseOrder.find(params[:id])
  end

  private

  def order_params
    params.require(:purchase_order).permit(:first_name, :last_name, :email, address_attributes: [:street1, :street2, :city, :state, :zip_code, :state_code, :country_code])
  end
end
