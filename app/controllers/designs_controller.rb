class DesignsController < ApplicationController
  def new
  end

  def create
    redirect_to design_path(text: text)
  end

  def show
    @text = text

    redirect_to design_path(text: "Supermeme") and return if @text.blank?

    selected_color = params.fetch("color", "Black")
    selected_size = params.fetch("size", "M")

    @design = "supreme"

    @product = Product.first
    @product_title = "#{@design.capitalize} style #{@product.title}"

    variants = @product.variants
    @variant = variants.where(color: selected_color, size: selected_size).first || variants.first
    @variant_title = "#{selected_color} #{@product_title} with \"#{@text}\""

    @image_path = generated_image_path(CGI::escape(@text), design: @design, size: 144)
    @mockup_path = mockup_image_path(CGI::escape(@text), variant_id: @variant.id)

    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def text
    params["text"]&.strip
  end
end
