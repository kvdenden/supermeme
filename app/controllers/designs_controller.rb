class DesignsController < ApplicationController
  def new
  end

  def show
    @text = params.fetch("text", "Supermeme")
    @image_path = generated_image_path(CGI::escape(@text), size: 144)
    @mockup_path = mockup_image_path(CGI::escape(@text))

    @product = Product.first
    @variants = @product.variants

    @available_colors = @variants.pluck(:color).uniq
    @available_sizes = @variants.pluck(:size).uniq
  end
end
