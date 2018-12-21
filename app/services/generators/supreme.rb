module Generators
  class Supreme
    BASE_SIZE = 720
    RED = "#da2727"

    def self.call(text, size: BASE_SIZE)
      Rails.cache.fetch("generators/supreme/#{text}/#{size}") do
        # create image
        image = Magick::Image.new(8000, 1000) do |image|
          image.background_color = RED
          image.format = 'PNG'
        end

        # create and set up draw object
        draw = Magick::Draw.new do
          self.gravity = Magick::CenterGravity
          self.fill = "white"
          self.pointsize = 720
          self.font = File.join(__dir__, "assets", "Futura Heavy Italic.ttf")
        end
        # reduce spacing between letters
        draw.kerning = -36

        # draw text on image
        draw.annotate(image, 0, 0, 0, 0, text)

        # make image same size as text by removing whitespace
        image.trim!

        # stretch image vertically
        image.resize!(image.columns, image.rows * 1.1)

        # add padding
        image.border!(240, 80, RED)

        if size != BASE_SIZE
          scale_factor = size / BASE_SIZE.to_f
          image.resize!(image.columns * scale_factor, image.rows * scale_factor)
        end

        # return image
        image
      end
    end
  end
end
