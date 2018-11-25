module Generators
  class Supreme
    BASE_SIZE = 720
    RED = "#da2727"

    def self.call(text, size: BASE_SIZE)
      # create image
      image = Magick::Image.new(8000, 1000) { self.background_color = RED }

      # create and set up draw object
      draw = Magick::Draw.new do
        self.gravity = Magick::CenterGravity
        self.fill = "white"
        self.pointsize = 720
        self.font = "./lib/assets/Futura Heavy Italic.ttf"
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

      # write image to file
      image_path = Tempfile.new(['supermeme', '.png'], File.join(Dir.tmpdir, 'designs')).path
      image.write(image_path)

      # return path of file
      filename = image_path.split("/").last
      File.join("/designs", filename)
    end
  end
end
