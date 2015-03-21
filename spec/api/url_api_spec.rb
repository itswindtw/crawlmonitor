require 'spec_helper'

def app
  API::Base
end

describe API::UrlAPI do
  include Rack::Test::Methods

  context 'GET /urls' do
    it 'return 404' do
      get '/urls/google.com/test'
      expect(last_response.status).to eq(404)
    end

    it 'return with empty regions' do
      Url.create(url: 'google.com/test')

      get '/urls/google.com/test'
      expect(last_response.status).to eq(200)
      expect(parsed_response).to eq('regions' => [])
    end

    it 'return with 2 regions' do
      u = Url.create(url: 'google.com/test')
      u.add_region(index: 'abcdefg/hijklmn', hash: 'yeah')
      u.add_region(index: 'abcdefg/hijklmn/@@', hash: 'yeahtt')

      get '/urls/google.com/test'
      expect(last_response.status).to eq(200)
      expect(parsed_response['regions'].length).to eq(2)
    end
  end

  context 'POST /urls' do
    it 'create new record' do
      expect(Url.all.length).to eq(0)

      post_json('/urls/google.com/test', { regions: [{ index: 'test', hash: 'test' }] })

      expect(last_response.status).to eq(201)
      expect(Url.all.length).to eq(1)
      expect(parsed_response['regions'].length).to eq(1)
    end
  end

end
