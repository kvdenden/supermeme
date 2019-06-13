# frozen_string_literal: true

module Mockups
  class TShirt
    COLOR_CONFIG = {
      'Black' => {
        filename: 'tshirt-black.jpg',
        offset_x: 0,
        offset_y: -30,
        rotation: -2
      },
      'White' => {
        filename: 'tshirt-white.jpg',
        offset_x: 15,
        offset_y: -30,
        rotation: 8
      }
    }.freeze

    def initialize(color: 'Black')
      config = COLOR_CONFIG[color]
      raise ArgumentError, 'Unsupported Color' if config.nil?

      @filename = config[:filename]
      @offset_x = config[:offset_x]
      @offset_y = config[:offset_y]
      @rotation = config[:rotation]
    end

    def call(design, max_width: 1200, max_height: 1200)
      product_file_path = File.join(__dir__, 'assets', @filename)
      product_file = File.open(product_file_path)
      product = Magick::Image.read(product_file).first

      canvas_width = 300
      canvas_height = 400
      resized_design = design.resize_to_fit(canvas_width, canvas_height)

      resized_design.rotate!(@rotation) unless @rotation.zero?

      product.composite!(resized_design, Magick::CenterGravity, @offset_x, @offset_y, Magick::OverCompositeOp)

      product.resize_to_fit!(max_width, max_height) unless max_width == 1200 && max_height == 1200
      product.sharpen(0)
    ensure
      resized_design&.destroy!
      product&.destroy!
    end
  end
end
