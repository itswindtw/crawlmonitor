require 'spec_helper'

def app
  API::Base
end

describe API::Base do
  include Rack::Test::Methods

  context 'Notfound error' do
    before { get '404' }
    it { expect(last_response.status).to eq(404) }
  end
end
