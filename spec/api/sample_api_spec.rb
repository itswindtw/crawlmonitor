require 'spec_helper'

def app
  API::Base
end

# describe API::SampleAPI do
#   include Rack::Test::Methods

#   context '/hello' do
#     before { get 'hello' }
#     it 'return default response' do
#       hash = { 'Hello' => 'Rack' }
#       expect(parsed_response).to eq(hash)
#     end
#   end
# end
