class OrdersController < ApplicationController
  def new
    redirect_to root_url if cart.empty?

    @order = cart.dup

    @address = @order.address || Address.new

    if flash[:validate]
      @order.validate
      @address.validate
    end
  end

  def create
    @order = cart

    if @order.update(order_params)
      redirect_to action: :pay
    else
      @order.save(validate: false)
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
    # TODO: move this to a background job
    Printful::CreateOrder.new(@order).call

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
