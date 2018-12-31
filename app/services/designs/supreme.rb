module Designs
  class Supreme
    def self.call(text, variant)
      # get dimensions of printfile
      canvas_width = variant.printfile.width
      canvas_height = variant.printfile.height

      canvas = Magick::Image.new(canvas_width, canvas_height) do |image|
        image.background_color = 'Transparent'
        image.format = 'PNG'
      end

      # calculate suitable font size
      font_size = canvas_width * 0.15
      design = generator.call(text, size: font_size)

      # scale down design if it is too big
      max_width = canvas_width * 0.9
      if design.columns > max_width
        design.resize!(max_width / design.columns)
      end

      # place design on canvas
      offset_y = canvas_height * -0.25
      canvas.composite!(design, Magick::CenterGravity, 0, offset_y, Magick::OverCompositeOp)
    end

    def self.generator
      Generators::Supreme
    end
  end
end
