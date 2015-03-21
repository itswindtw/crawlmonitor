require 'grape'

require 'api/url_api'
require 'api/event_api'

module API
  class Base < Grape::API
    format :json

    helpers do
      def logger
        Base.logger
      end
    end

    # handle default exception
    rescue_from :all do |e|
      Base.logger.error(e)
      rack_response({})
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      rack_response(e.to_json, 400)
    end

    # mount APIs here
    mount API::UrlAPI
    mount API::EventAPI
  end
end
