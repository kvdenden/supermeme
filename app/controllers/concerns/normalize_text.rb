# frozen_string_literal: true

module NormalizeText
  def normalized_text
    params['text']
      .to_s
      .strip
      .then { |text| CGI.unescape(text) }
    # .then { |text| I18n.transliterate(text) }
  end
end
