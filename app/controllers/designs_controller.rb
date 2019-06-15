# frozen_string_literal: true

class DesignsController < ApplicationController
  include NormalizeText

  def new
    @text = normalized_text
    puts "text is #{@text}"
  end

  def create
    redirect_to design_path(text: normalized_text)
  end

  def show
    @text = normalized_text

    redirect_to(design_path(text: 'Supermeme')) && return if @text.blank?
    redirect_to(design_path(text: @text.slice(0, 24))) && return if @text.length > 24

    selected_color = params.fetch('color', 'Black')
    selected_size = params.fetch('size', 'M')

    @design = 'supreme'
    @design_title = "#{@design.capitalize} style #{@text}"

    @product = Product.first
    @product_title = "#{@design.capitalize} style #{@product.title}"

    variants = @product.variants
    @variant = variants.where(color: selected_color, size: selected_size).first || variants.first
    @variant_title = "#{selected_color} #{@product_title} with \"#{@text}\""

    @image_url = generated_image_url(@text, design: @design, size: 144)
    @mockup_url = mockup_image_url(@text, color: selected_color.parameterize)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
