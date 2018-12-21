class OrderMailer < ApplicationMailer
  default from: 'orders@supermeme.co'

  def order_confirmation
    @order = params[:order]
    make_bootstrap_mail(to: @order.email, subject: 'Order Confirmation')
  end
end
