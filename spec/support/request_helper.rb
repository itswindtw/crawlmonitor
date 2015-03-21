require 'json'

module Request
  module Helpers
    def send_json(method, uri, json)
      send(method, uri, json.to_json, 'CONTENT_TYPE' => 'application/json')
    end
  end
end
