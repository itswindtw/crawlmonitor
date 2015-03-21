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
      u.add_region(index: 'abcdefg/hijklmn', hash_val: 'yeah')
      u.add_region(index: 'abcdefg/hijklmn/@@', hash_val: 'yeahtt')

      get '/urls/google.com/test'
      expect(last_response.status).to eq(200)
      expect(parsed_response['regions'].length).to eq(2)
    end
  end

  context 'POST /urls' do
    it 'create new record' do
      expect(Url.all.length).to eq(0)

      send_json(:post, '/urls/google.com/test', regions: [{ index: 'test', hash_val: 'test' }])

      expect(last_response.status).to eq(201)
      expect(Url.all.length).to eq(1)
      expect(parsed_response['regions'].length).to eq(1)

      expect(Url.where(url: 'google.com/test').empty?).to eq(false)
    end

    it 'reject empty regions' do
      send_json(:post, '/urls/google.com/test', {})

      expect(last_response.status).to eq(400)
    end
  end

  context 'PUT /urls' do
    before do
      @u = Url.create(url: 'google.com/test')
      @u.add_region(index: '123', hash_val: '456')
    end

    it 'add regions' do
      send_json(:put, '/urls/google.com/test', regions: [{ index: '456', hash_val: 'test' }])

      expect(@u.regions.length).to eq(2)
    end

    it 'update regions' do
      send_json(:put, '/urls/google.com/test', regions: [
        { index: '123', hash_val: 'windtw' },
        { index: '456', hash_val: 'test' }])

      expect(Region.where(url: @u, index: '123').first.hash_val).to eq('windtw')
    end
  end
end
