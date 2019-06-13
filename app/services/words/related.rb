# frozen_string_literal: true

module Words
  class Related
    def self.call(word, amount = 10, minLength: 5)
      request_uri = "https://api.datamuse.com/words?rel_trg=#{CGI.escape(word)}&max=#{amount}&sp=#{'?' * minLength}*"
      response = RestClient.get(request_uri)

      JSON.parse(response.body).map { |result| result['word'].capitalize }
    end
  end
end
