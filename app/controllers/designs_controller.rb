class DesignsController < ApplicationController
  def new
  end

  def create
    redirect_to design_path(text: text)
  end

  def show
    @text = text

    @image_path = generated_image_path(CGI::escape(@text), size: 144)
    @mockup_path = mockup_image_path(CGI::escape(@text))

    @product = Product.first
    @variants = @product.variants

    @available_colors = @variants.pluck(:color).uniq
    @available_sizes = @variants.pluck(:size).uniq
  end

  private

  def text
    input_text = params["text"]&.strip

    if input_text.present?
      input_text
    else
      "Supermeme"
    end
  end
end
