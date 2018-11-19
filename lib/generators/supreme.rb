module Generators
  class Supreme
    DEFAULT_OPTIONS = {
      color: "white",
      background_color: "#da2727",
      background_alpha: "ff",
      font_size: 192,
      font_path: "./lib/assets",
      font: "Futura-Bold-Italic.ttf",
      kerning: -10,
      width: 2000
    }

    def self.call(text, **options)
      MagickTitle.say(text, DEFAULT_OPTIONS.merge(options)).url
    end
  end
end
