class CartController < ApplicationController
  def add
    product = Product.first

    color = params.fetch(:color)
    size = params.fetch(:size)
    text = params.fetch(:text)

    variant = product.variants.where(color: color, size: size).first
    generator = "supreme"

    order = cart
    order.save unless order.persisted?

    existing_item = order.line_items.where(variant: variant, text: text, generator: generator).first

    if existing_item
      existing_item.quantity += 1
      existing_item.save
    else
      new_item = LineItem.new(
        variant: variant,
        text: text,
        generator: generator,
        quantity: 1
      )
      order.line_items << new_item
    end
    session[:cart_id] = order.id

    redirect_to action: :show
  end

  def show
    @order = cart
  end
end
