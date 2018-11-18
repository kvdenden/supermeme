module Generators
  class Supreme
    def self.call(text)
      MagickTitle.say(text).url
    end
  end
end
