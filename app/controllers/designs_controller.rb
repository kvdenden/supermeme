# frozen_string_literal: true

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

    @image_url = generated_image_url(CGI::escape(@text), design: @design, size: 144)
    @mockup_url = mockup_image_url(CGI::escape(@text), color: selected_color.parameterize)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def text
    params["text"]&.strip
  end
end
