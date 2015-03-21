require 'spec_helper'

def app
  API::Base
end

describe API::UrlAPI do
  include Rack::Test::Methods

  context '/urls' do
    it 'return 404' do
      get '/urls/google1'
      expect(last_response.status).to eq(404)
    end

    it 'return something' do
      Url.create(url: 'google')

      get '/urls/google'
      expect(last_response.status).to eq(200)
      expect(parsed_response).to eq('regions' => [])
    end
  end
end
