require 'grape'

require 'api/url_api'

module API
  class Base < Grape::API
    format :json

    # handle default exception
    rescue_from :all do |_e|
      rack_response({})
    end

    # mount APIs here
    mount API::UrlAPI
  end
end
