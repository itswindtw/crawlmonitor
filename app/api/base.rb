require 'grape'

module API
  require 'api/url_api'

  class Base < Grape::API
    format :json

    helpers do
      def logger
        Base.logger
      end
    end

    # handle default exception
    rescue_from :all do |_e|
      rack_response({})
    end

    # mount APIs here
    mount API::UrlAPI
  end
end
