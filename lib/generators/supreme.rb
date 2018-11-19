module Generators
  class Supreme
    RED = "#da2727"

    def self.call(text)
      # create image
      image = Magick::Image.new(2000, 1000) { self.background_color = RED }

      # create and set up draw object
      draw = Magick::Draw.new do
        self.gravity = Magick::CenterGravity
        self.fill = "white"
        self.pointsize = 192
        self.font = "./lib/assets/Futura-Bold-Italic.ttf"
      end
      draw.kerning = -10

      # draw text on image
      draw.annotate(image, 0, 0, 0, 0, text)

      # trim image
      image.trim!

      # add border to image
      image.border!(20, 10, RED)

      # write image to file
      image_path = Tempfile.new(['hello', '.png'], '/tmp/designs').path
      image.write(image_path)

      # return path of file
      filename = image_path.split("/").last
      File.join("/designs", filename)
    end
  end
end
