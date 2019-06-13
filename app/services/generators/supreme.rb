# frozen_string_literal: true

module Generators
  class Supreme
    BASE_SIZE = 720
    RED = '#da2727'

    def self.move_down?(text)
      tall_ascenders = 'ÀÁÂÃÄÅÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ'
      ascenders = '!"#$%&\'()*+/0123456789?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^`bdfhijklt{|}¢£¤¥¦§¨©ª®¯°±²³´¶¹º¼½¾ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåèéêëìíîïðñòàáâãäåèéêëìíîïðñòóôõö÷ùúûüýþÿ'
      descenders = '$(),/;[\]_gjpqy{|}¡¦§µ¶¸¿ÇÞçýþÿ'
      contains_tall_ascenders = tall_ascenders.chars.any? { |ch| text.include?(ch) }
      contains_ascenders = ascenders.chars.any? { |ch| text.include?(ch) }
      contains_descenders = descenders.chars.any? { |ch| text.include?(ch) }

      contains_tall_ascenders || (contains_ascenders && !contains_descenders)
    end

    def self.call(text, size: BASE_SIZE)
      # escape special characters
      # escaped_text = text.dump[1...-1].gsub('%', '%%')
      escaped_text = text.gsub('%', '%%').gsub('\\', '\\\\\\\\')

      puts "text is #{escaped_text}"

      # create and set up draw object
      draw = Magick::Draw.new do
        self.gravity = Magick::CenterGravity
        self.fill = 'white'
        self.pointsize = 720
        self.font = File.join(__dir__, 'assets', 'FuturaPTHeavyOblique.otf')
      end

      # reduce spacing between letters
      draw.kerning = -36

      # calculate image dimensions
      type_metrics = draw.get_type_metrics(escaped_text)

      image_width = [type_metrics.width + 360, 720 * 4].max
      image_height = type_metrics.height

      # create image
      image = Magick::Image.new(image_width, image_height) do |image|
        image.background_color = RED
        image.format = 'PNG'
      end

      offset_y = -72
      offset_y = 0 if move_down?(escaped_text)

      # draw text on image
      draw.annotate(image, 0, 0, 0, offset_y, escaped_text)

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
