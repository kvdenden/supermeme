module Mockups
  class TShirt
    def self.call(design, max_width: 1200, max_height: 1200)
      Rails.cache.fetch("mockups/supreme/#{design.hash}/#{max_width}x#{max_height}") do
        mockup_file_path = File.join(__dir__, "assets", "tshirt-black.jpg")
        mockup_file = File.open(mockup_file_path)
        mockup = Magick::Image.read(mockup_file).first

        canvas_width = 300
        canvas_height = 400
        resized_design = design.resize_to_fit(canvas_width, canvas_height)

        offset_y = -30
        mockup.composite!(resized_design, Magick::CenterGravity, 0, offset_y, Magick::OverCompositeOp)

        mockup.resize_to_fit(max_width, max_height).sharpen(0)
      end
    end
  end
end
