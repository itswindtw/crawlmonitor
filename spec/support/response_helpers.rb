module Response
  module Helpers
    def parsed_response
      # wrap in Hashie(Grape)
      Hashie::Mash.new(JSON.parse(last_response.body))
    end
  end
end
