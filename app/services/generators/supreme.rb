module Generators
  class Supreme
    BASE_SIZE = 720
    RED = "#da2727"

    def self.call(text, size: BASE_SIZE)
      # escape special characters
      escaped_text = text.dump[1...-1].gsub('%', '%%')

      # create and set up draw object
      draw = Magick::Draw.new do
        self.gravity = Magick::CenterGravity
        self.fill = "white"
        self.pointsize = 720
        self.font = File.join(__dir__, "assets", "Futura Heavy Italic.ttf")
      end
      # reduce spacing between letters
      draw.kerning = -36

      # calculate image dimensions
      type_metrics = draw.get_type_metrics(escaped_text)

      image_width = type_metrics.width + 100
      image_height = type_metrics.height + 100

      # create image
      image = Magick::Image.new(image_width, image_height) do |image|
        image.background_color = RED
        image.format = 'PNG'
      end

      # draw text on image
      draw.annotate(image, 0, 0, 0, 0, escaped_text)

      # make image same size as text by removing whitespace
      image.trim!

      # calculate padding
      min_height = 800
      vertical_padding = [
        75, # default padding
        (min_height - image.rows) / 2, # for short text
        image.columns / 50 # for long text
      ].max

      min_width = 2000
      horizontal_padding = [
        250, # default padding
        (min_width - image.columns) / 2, # for short text
        vertical_padding # for long text
      ].max

      # add padding
      image.border!(horizontal_padding, vertical_padding, RED)

      # stretch image vertically
      image.resize!(image.columns, image.rows * 1.1)

      if size != BASE_SIZE
        scale_factor = size / BASE_SIZE.to_f
        image.resize!(image.columns * scale_factor, image.rows * scale_factor)
      end

      # return image
      image
    end
  end
end
