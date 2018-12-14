class CheckoutController < ApplicationController
  def create
    @product = Product.first

    color = params.fetch(:color)
    size = params.fetch(:size)
    variant = @product.variants.where(color: color, size: size).first
    generator = "supreme"

    @text = params.fetch(:text)

    @mockup_path = mockup_image_path(CGI::escape(@text))

    @line_item = LineItem.new(
      variant: variant,
      text: @text,
      generator: generator,
      quantity: 1
    )

    render :show
  end
end
