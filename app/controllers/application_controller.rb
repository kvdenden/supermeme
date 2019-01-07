# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :cart

  def cart
    cart_id = session[:cart_id]
    if cart_id.present?
      old_cart = PurchaseOrder.find_by(id: cart_id)
      if old_cart.nil?
        session[:cart_id] = nil
        PurchaseOrder.new
      else
        old_cart
      end
    else
      PurchaseOrder.new
    end
  end

  private

  def noindex
    set_meta_tags noindex: true
  end
end
