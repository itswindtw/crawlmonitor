require 'spec_helper'

def app
  API::Base
end

describe API::EventAPI do
  include Rack::Test::Methods

  before do
    def gen_random
      ('a'..'z').to_a.shuffle[0, 8].join
    end

    @events = 1.upto(100).map do
      Event.create(url: gen_random, index: gen_random, hash_val: gen_random)
    end
  end

  context 'GET /events' do
    it 'show some events limit to PAGING_COUNT' do
      get '/events'

      expect(last_response.status).to eq(200)
      expect(parsed_response['data'].length).to eq(subject.class.const_get 'PAGING_COUNT')
      expect(parsed_response['data'].first['id']).to eq(@events.last.id)
    end

    it 'show following events according to start_at' do
      get '/events?start_at=84'

      expect(last_response.status).to eq(200)
      expect(parsed_response['data'].length).to eq(subject.class.const_get 'PAGING_COUNT')
      expect(parsed_response['data'].first['id']).not_to eq(@events.last.id)
    end
  end
end
