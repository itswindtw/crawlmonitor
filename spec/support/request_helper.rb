require 'json'

module Request
  module Helpers
    def post_json(uri, json)
      post(uri, json.to_json, { 'CONTENT_TYPE' => 'application/json' })
    end
  end
end
