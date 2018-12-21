# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def order_confirmation
    order = PurchaseOrder.find_by(id: params[:order_id]) || PurchaseOrder.first

    OrderMailer.with(order: order).order_confirmation
  end
end
