class OrdersController < ApplicationController
  def new
    redirect_to root_url if cart.empty?

    @order = cart.dup

    @address = @order.address || Address.new

    flash[:printful_errors]&.each do |err|
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
      ok_for_printful = Printful::ValidateOrder.new(order).call
      if ok_for_printful
        redirect_to action: :pay
      else
        flash[:printful_errors] = order.errors[:base]
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

    # send order to printful
    confirm_order = Rails.application.config.printful[:confirm_order]
    Printful::CreateOrder.new(@order).call(confirm: confirm_order)

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
    params.require(:purchase_order).permit(:name, :email, address_attributes: [:street1, :street2, :city, :state, :zip_code, :state_code, :country_code])
  end
end
