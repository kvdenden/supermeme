# frozen_string_literal: true

module Designs
  class Supreme
    def self.call(text, printfile)
      # get dimensions of printfile
      canvas_width = printfile.width
      canvas_height = printfile.height

      canvas = Magick::Image.new(canvas_width, canvas_height) do |image|
        image.background_color = 'Transparent'
        image.format = 'PNG'
      end

      # calculate suitable font size
      font_size = canvas_width * 0.125
      design = generator.call(text, size: font_size)

      # scale down design if it is too big
      max_width = canvas_width * 0.9
      design.resize!(max_width / design.columns) if design.columns > max_width

      # place design on canvas
      offset_y = canvas_height * -0.25
      canvas.composite!(design, Magick::CenterGravity, 0, offset_y, Magick::OverCompositeOp)
    ensure
      design&.destroy!
    end

    def self.generator
      Generators::Supreme
    end
  end
end
