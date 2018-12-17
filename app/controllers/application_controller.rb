class ApplicationController < ActionController::Base
  helper_method :cart

  def cart
    if !session[:cart_id].nil?
      PurchaseOrder.find(session[:cart_id])
    else
      PurchaseOrder.new
    end
  end
end
