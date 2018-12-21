class CartController < ApplicationController
  def add
    product = Product.first

    color = params.fetch(:color)
    size = params.fetch(:size)
    text = params.fetch(:text)

    variant = product.variants.where(color: color, size: size).first
    generator = "supreme"

    order = cart

    if order.new_record?
      country_code = request.location.country_code
      order.address = Address.new(country_code: country_code) if country_code.present?
      order.save(validate: false)
    end

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

  def remove
    line_item = cart.line_items.find_by(id: params[:line_item_id])
    line_item.destroy if line_item

    respond_to do |format|
      format.js { render :update }
      format.html { redirect_to action: :show }
    end
  end

  def update
    line_item = cart.line_items.find_by(id: params[:line_item_id])
    quantity = params[:quantity].to_i

    line_item.update(quantity: quantity) if line_item && quantity.positive?

    respond_to do |format|
      format.js { render :update }
      format.html { redirect_to action: :show }
    end
  end

  def show
  end
end
